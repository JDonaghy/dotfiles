-- Global settings and platform detection

-- WSL detection
_G.IS_WSL = vim.loop.os_uname().sysname and vim.fn.system('uname -a'):find 'WSL2'
needGo = not _G.IS_WSL

-- Dart/Flutter settings
vim.g.dart_format_on_save = 1
vim.g.dart_trailing_comma_indent = true

-- WSL-specific clipboard configuration
if _G.IS_WSL then
  vim.g.clipboard = {
          name = "win32yank-wsl",
          copy = {
              ["+"] = "win32yank.exe -i --crlf",
              ["*"] = "win32yank.exe -i --crlf",
          },
          paste = {
              ["+"] = "win32yank.exe -o --lf",
              ["*"] = "win32yank.exe -o --lf",
          },
          cache_enabled = true,
      }
end