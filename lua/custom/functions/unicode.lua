-- Helper function to convert Unicode escape sequences in a string
local function convert_unicode_string(text)
  -- Pattern to match \uXXXX or \UXXXXXXXX format
  local result = text:gsub("\\u([0-9a-fA-F]+)", function(hex)
    local codepoint = tonumber(hex, 16)
    if codepoint then
      -- Convert codepoint to UTF-8 character
      return vim.fn.nr2char(codepoint)
    else
      return "\\u" .. hex -- Return original if conversion fails
    end
  end)

  return result
end

-- Main function to convert Unicode escape sequences to symbols
local function convert_unicode_to_symbol()
  -- Get the visual selection
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  -- Get the selected text
  local lines = vim.fn.getline(start_pos[2], end_pos[2])

  if #lines == 0 then
    print("No text selected")
    return
  end

  -- Handle single line selection
  if #lines == 1 then
    local line = lines[1]
    local start_col = start_pos[3]
    local end_col = end_pos[3]

    -- Extract the selected portion
    local selected_text = string.sub(line, start_col, end_col)

    -- Convert Unicode escape sequences
    local converted = convert_unicode_string(selected_text)

    -- Replace the selected text
    local new_line = string.sub(line, 1, start_col - 1) .. converted .. string.sub(line, end_col + 1)
    vim.fn.setline(start_pos[2], new_line)
  else
    -- Handle multi-line selection (process each line)
    for i, line in ipairs(lines) do
      local line_num = start_pos[2] + i - 1
      local converted_line

      if i == 1 then
        -- First line: from start_col to end
        local selected_part = string.sub(line, start_pos[3])
        converted_line = string.sub(line, 1, start_pos[3] - 1) .. convert_unicode_string(selected_part)
      elseif i == #lines then
        -- Last line: from start to end_col
        local selected_part = string.sub(line, 1, end_pos[3])
        converted_line = convert_unicode_string(selected_part) .. string.sub(line, end_pos[3] + 1)
      else
        -- Middle lines: entire line
        converted_line = convert_unicode_string(line)
      end

      vim.fn.setline(line_num, converted_line)
    end
  end

  print("Unicode sequences converted to symbols")
end

-- CUSTOM.CustomFunctions.unicode_converter = convert_unicode_to_symbol

-- -- Setup function to create commands and keymaps
-- -- function M.setup(opts)
--   opts = opts or {}
--
--   -- Create the command
--   vim.api.nvim_create_user_command('ConvertUnicode', M.convert_unicode_to_symbol, {
--     range = true,
--     desc = 'Convert Unicode escape sequences to symbols in visual selection'
--   })
--
--   -- Create key mapping if specified
--   local keymap = opts.keymap or '<leader>cu'
--   if keymap then
--     vim.keymap.set('v', keymap, ':<C-u>ConvertUnicode<CR>', {
--       desc = 'Convert Unicode escape sequences to symbols',
--       silent = true
--     })
--   end
-- -- end
--
-- -- return M

return convert_unicode_to_symbol
