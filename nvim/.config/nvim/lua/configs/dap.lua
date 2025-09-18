local dap = require("dap")

require("dap-vscode-js").setup({
  adapters = { 'node', 'pwa-node', 'node-terminal' },
})

dap.adapters["pwa-node"] = {
  type = "server",
  host = "0.0.0.0",
  port = 9229,
  executable = {
    command = "js-debug-adapter",
  }
}

for _, language in ipairs { "typescript", "javascript" } do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
      runtimeExecutable = "node",
      -- runtimeExecutable = "ts-node-dev",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require("dap.utils").pick_process,
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
    },
    -- Debug web applications (client side)
    {
      type = "pwa-chrome",
      request = "launch",
      name = "Launch & Debug Chrome",
      url = function()
        local co = coroutine.running()
        return coroutine.create(function()
          vim.ui.input({
            prompt = "Enter URL: ",
            default = "http://localhost:3000",
          }, function(url)
            if url == nil or url == "" then
              return
            else
              coroutine.resume(co, url)
            end
          end)
        end)
      end,
      webRoot = vim.fn.getcwd(),
      protocol = "inspector",
      sourceMaps = true,
      userDataDir = false,
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Jest Tests",
      -- trace = true, -- include debugger info
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/jest/bin/jest.js",
        "--runInBand",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Debug: ezycab",
      remoteRoot = "/app",
      localRoot = "${workspaceFolder}/ezycab-api",
      port = 9229,
      restart = true,
      address = "0.0.0.0",
      skipFiles = { "<node_internals>/**" },
      adapters = { 'pwa-node' },
    }
  }
end

-- dap.adapters['pwa-node'] = {
--   type = 'server',
--   host = '127.0.0.1',
--   port = 9229,
-- }
-- dap.configurations.javascript = {
--   {
--     type = 'pwa-node',
--     request = 'launch',
--     name = 'Launch program',
--     program = '${file}',
--     runtimeExecutable = "node",
--   },
-- }
-- dap.configurations.typescript = {
--   {
--     type = 'pwa-node',
--     request = 'launch',
--     name = 'Launch program',
--     program = '${file}',
--     runtimeExecutable = "ts-node-dev",
--   },
-- }
