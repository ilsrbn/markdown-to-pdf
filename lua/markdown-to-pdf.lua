local M = {}

local uv = vim.loop

M.run_pandoc = function()
  local file = vim.fn.expand('%:p')
  local file_base = vim.fn.expand('%:t:r')
  local pdf_file = file_base .. '.pdf'

  local stdout = uv.new_pipe(false)
  local stderr = uv.new_pipe(false)
  local handle

  handle = uv.spawn('pandoc', {
    args = { file, '-o', pdf_file },
    stdio = { nil, stdout, stderr }
  }, function(code, signal)
    stdout:close()
    stderr:close()
    handle:close()
    if code == 0 then
      print("Pandoc conversion successful!")
      -- Schedule the jobstart call to run outside the callback
      vim.schedule(function()
        vim.fn.jobstart({ 'xdg-open', pdf_file }, { detach = true })
      end)
    else
      print("Pandoc conversion failed with code " .. code .. " and signal " .. signal)
    end
  end)

  uv.read_start(stdout, function(err, data)
    assert(not err, err)
    if data then
      print("stdout: " .. data)
    end
  end)

  uv.read_start(stderr, function(err, data)
    assert(not err, err)
    if data then
      print("stderr: " .. data)
    end
  end)
end

return M

