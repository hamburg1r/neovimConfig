local function compress(m, t)
  for _, keymap in ipairs(t) do
    local modes = keymap.mode or { 'n' }
    for _, mode in ipairs(modes) do
      local out = {}
      local opts = {}
      out[1] = mode
      out[2] = keymap[1]
      out[3] = keymap[2]
      for k, v in pairs(keymap) do
        if k ~= 'mode' and type(k) ~= 'number' then
          opts[k] = v
        end
      end
      if opts ~= {} then
        out[4] = opts
      end
      table.insert(m, out)
    end
  end
end

local function setup_keymaps(keymaps, enabled_categories)
  enabled_categories = enabled_categories or {
    'basic',
    'custom'
    -- 'ssr',
    -- 'dap',
    -- 'tiny_code_action',
    -- 'snacks',
    -- 'flutter_bloc',
    -- 'git_conflict',
    -- 'gitsigns'
  }

  for k, v in pairs(keymaps) do
    local keys = {}

    -- Check if this category should be enabled
    for _, category in ipairs(enabled_categories) do
      if k == category then
        compress(keys, v)
        break
      end
    end

    -- Set up the keymaps
    for _, key in ipairs(keys) do
      vim.keymap.set(key[1], key[2], key[3], key[4] or {})
    end
  end
end

-- Usage example:
-- setup_keymaps(keymaps)
--
-- Or with custom categories:
-- setup_keymaps(keymaps, {'basic', 'custom', 'gitsigns'})

return setup_keymaps
