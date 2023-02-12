-- 2023.02.12 Lazy로 패키지 매니저를 바꾸고, dap설치
-- 2023.02.07 lionhairdino at gmail.com
-- 자동 완성 엔진을 Coq에서 nvim-cmp로 바꿨다.
--
-- 2022.10.31
--
-- Haskell Language Server + LSP Native + Coq
--
-- ※ Coq은 증명 언어를 얘기하는 게 아니라, 자동 완성 플러그인 이름이다.
-- Native가 아닌 Coc으로 설정할 때는 자동 완성이 따로 필요없지만,
-- Native로 할 때는 필요하다.
--
-- 2023.2.4
-- Coq에 알 수 없는 오류가 있어, mini.completion 쓸까도 했는데, 다른 많은 플러그인들이
-- 디폴트로 nvim-cmp 설정을 언급한다. 지금은 자동 완성 엔진으로 nvim-cmp를 쓴다.
--
-- :Hoogle 후글 검색

local set = vim.opt
set.mouse = 'a'
set.number = true
set.ignorecase = true
set.smartcase = true
set.hlsearch = true
set.wrap = true
set.breakindent = true
set.tabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.autoindent = true
set.smartindent = true
set.softtabstop = 2
set.hidden = true
--set.nocompatible = true -- nvim은 이 옵션은 무시한다.
set.splitbelow = true
set.splitright = true
set.clipboard = 'unnamedplus'
set.undodir = vim.fn.stdpath('cache') .. '/undodir/'
set.undofile = true

set.printencoding = 'utf8'
set.printmbcharset = 'ISO10646'
set.printmbfont = 'r:D0CodingLigature,c:yes,a:yes'
set.printfont = 'D2CodingLigature:h10'
--set.printdevice = 'FUJI_XEROX_DocuPrint_CP225_228_w_'
set.printdevice = 'HP-LaserJet-1200'
--set.timeoutlen = 300
set.termguicolors = true
--set.updatetime = 1200 -- nvim_create_autocmd에서 사용
------ Nvim-tree
-- 기본 탐색기 끄기
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g['oceanic_next_terminal_bold'] = 1
vim.g['oceanic_next_terminal_italic'] = 1

vim.g['vim_markdown_folding_disabled'] = 1
vim.g['neoterm_size'] = 10
vim.g['neoterm_autoinsert'] = 1
vim.g['fzf_preview_window'] = { 'hidden,right,50%,<70(up,40%)', 'ctrl-/' }
-- [Buffers] 이미 윈도우가 존재하면, 그리로 점프한다.
vim.g['fzf_buffers_jump'] = 1
-- [[B]Commits] 'git log'가 쓰는 옵션 커스터마이징
vim.g['fzf_commits_log_options'] = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
-- [Tags] 태그 파일 생성 명령어
vim.g['fzf_tags_command'] = 'ctags -R'
-- [Commands] --expect expression for directly executing the command
vim.g['fzf_commands_expect'] = 'ctrl-enter,ctrl-x'
vim.g['mkdp_theme'] = 'light'

--vim.cmd.colorscheme('OceanicNext')
--vim.g.material_style = "oceanic-next"
-- 입력 모드일 때만 row를 표시하는 선line을 가린다.
vim.api.nvim_create_autocmd(
  { "InsertEnter" },
  { pattern = "*",
    command = "set nocul" }
)
vim.api.nvim_create_autocmd(
  { "InsertLeave" },
  { pattern = "*",
    command = "set cul" }
)
-- 터미널에 포커스가 가면 자동으로 입력모드
vim.api.nvim_create_autocmd(
  { "BufWinEnter", "WinEnter" },
  { pattern = "term://*",
    command = "startinsert" }
)

-- 현재 vim을 시작한 폴더를 current 디렉토리로 바꾸려 했는데,
-- 작동하지 않는다.
vim.api.nvim_create_autocmd(
  { "InsertEnter" },
  { pattern = "*",
    command = ":cd %:h<CR>" }
)
vim.diagnostic.config({ virtual_text = true })

-- 점프키와 충돌
vim.keymap.set({ 'n' }, '<Tab>', ':bn<CR>', { silent = true })
vim.keymap.set({ 'n' }, 'k', 'gk', { silent = true })
vim.keymap.set({ 'n' }, 'j', 'gj', { silent = true })

-- Shift-BS는 작동하지 않고 있다. 이유는 아직 모른다.
vim.keymap.set({ 'i' }, '<Shift-BS>', '<kDel>', { silent = true })
vim.keymap.set({ 'i', 'n', 'v' }, '<leader>\\', ':Tnew<CR>', { silent = true })

--vim.keymap.set('n', '<F3>', ':LazyGit<CR>', { desc = 'Git' })
vim.keymap.set('n', '<F3>', ':Neogit kind=split<CR>', { desc = 'Git' })
vim.keymap.set({ 'n', 'v', 'i' }, '<leader>m', ':ToggleOnly<CR>', { desc = 'Send to new tab' })

-- 윈도우 크기 조절
vim.keymap.set('n', '=', ':resize +5<CR>', { desc = 'incresing height', silent = true })
vim.keymap.set('n', '-', ':resize -5<CR>', { desc = 'incresing height', silent = true })
vim.keymap.set('n', '+', ':vertical resize +5<CR>', { desc = 'incresing width', silent = true })
vim.keymap.set('n', '_', ':vertical resize -5<CR>', { desc = 'incresing width', silent = true })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

--vim.g.mapleader = " " -- make sure to set `mapleader` before lazy so your mappings are correct
--<Leader> 키를 지정하는 것 같다.

local function lsp_on_attach_keysetup(_ , bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'K', ':lua vim.lsp.buf.hover()<CR>', bufopts)
  vim.keymap.set('n', '<C-]>', ':lua vim.lsp.buf.definition()<CR>', bufopts)
  vim.keymap.set('n', 'gA', ':lua vim.lsp.buf.code_action()<CR>', bufopts)
  vim.keymap.set('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', bufopts)
  vim.keymap.set('n', 'gD', ':lua vim.lsp.buf.type_definition()<CR>', bufopts)
  vim.keymap.set('n', 'gw', ':lua vim.lsp.buf.workspace_symbol()<CR>', bufopts)
  vim.keymap.set('n', 'go', ':lua vim.diagnostic.open_float()<CR>', bufopts)
  vim.keymap.set('n', 'g[', ':lua vim.lsp.diagnostic.goto_prev()<CR>', bufopts)
  vim.keymap.set('n', 'g]', ':lua vim.lsp.diagnostic.goto_next()<CR>', bufopts)
  vim.keymap.set('n', 'gl', ':lua vim.diagnostic.setloclist()<CR>', bufopts)
  vim.keymap.set('n', 'gr', ':lua vim.lsp.buf.references()<CR>', bufopts)
  vim.keymap.set('n', 'gf', ':lua vim.lsp.buf.format{ async=true }<CR>', bufopts)
  vim.keymap.set('n', 'gR', ':lua vim.lsp.buf.rename()<CR>', bufopts)
  vim.keymap.set('n', 'gs', ':lua vim.lsp.codelens.refresh()<CR>', bufopts)
  vim.keymap.set('n', 'ge', ':lua vim.lsp.codelens.run()<CR>', bufopts)
end

local function lsp_on_attach(client, bufnr)
  lsp_on_attach_keysetup(client, bufnr);
  -- 매핑이 제대로 동작하는지 nvim 안에서 :map gd 등을 입력해서 알 수 있다.
  vim.opt_local.signcolumn = 'yes' -- 줄번호 왼쪽에 컬럼 하나를 둬서 W,H등을 표시하는 걸 말한다.
  vim.api.nvim_create_autocmd(
    { "BufEnter", "InsertLeave" },
    { pattern = { "*" },
      callback = function()
        vim.lsp.codelens.refresh()
      end
    }
  )

  -- require "lsp_signature".on_attach({ -- signatureHelp 관련,
  --     bind = true,
  --     handler_opts = {
  --       border = "rounded"
  --     }
  -- }, bufnr)
  set.tagfunc = 'lua vim.lsp.tagfunc()'

  -- 커서가 5초동안 가만히 있으면, 해당 키워드의 정보를 띄우려고 했는데,
  -- 에러 창을 띄워 보고 있다가, 정보창이 뜨면 에러창이 사라진다.
  -- CursorHold 이벤트는 주기적으로 계속 fire된다.
  -- 일단 사용 보류
  -- vim.api.nvim_create_autocmd(
  --   { "CursorHold" },
  --   { pattern = "*",
  --     callback = vim.lsp.buf.hover,
  --     --once = true,
  --   }
  -- )
end

function Config_mason()
  require 'mason'.setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      },
      border = "single"
    }
  })

  require("mason-lspconfig").setup {
    ensure_installed = {},
  }
  require("mason-lspconfig").setup_handlers {
    -- 키 없이 첫 번째로 정의한 함수는, 지정 핸들러가 없을 경우 쓰이는
    -- 디폴트 핸들러이다.
    function(server_name) -- default handler (optional)
      require("lspconfig")[server_name].setup { on_attach = lsp_on_attach }
    end,

    ["hls"] = function()
      require 'lspconfig'.hls.setup({
        --cmd = { "haskell-language-server-wrapper", "--lsp", "--debug" },
        cmd = { "haskell-language-server-wrapper", "--lsp" },
        filetypes = { "haskell", "lhaskell" },
        codeLens = { enabale = true },
        on_attach = lsp_on_attach,
--        capabilities = lsp_capabilities,
        settings = {
          haskell = {
            hlintOn = true,
            formattingProvider = "stylish-haskell",
          }
        }
      })
    end,

    ["sumneko_lua"] = function() 
      -- sumneko_lua가 deprecated 인데,mason은 아직 반영 전이다. 
      -- 그래서 키는 그대로 sumneko_lua로 두고 setup은 lua_ls로 했다.
      require 'lspconfig'.lua_ls.setup({
        on_attach = lsp_on_attach,
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT'
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })
    end,
  }
end

-- local lsp_signature_cfg = {
--   floating_window_off_x = 5, -- adjust float windows x position.
--   floating_window_off_y = function() -- adjust float windows y position.
--   e.g. set to -2 can make floating window move up 2 lines
--     local linenr = vim.api.nvim_win_get_cursor(0)[1] -- buf line number
--     local pumheight = vim.o.pumheight
--     local winline = vim.fn.winline() -- line number in the window
--     local winheight = vim.fn.winheight(0)
--
--     -- window top
--     if winline - 1 < pumheight then
--       return pumheight
--     end
--
--     -- window bottom
--     if winheight - winline < pumheight then
--       return -pumheight
--     end
--     return 0
--   end,
-- }

require("lazy").setup({
  { 'sainnhe/everforest',
    lazy = false,
    config = function()
      vim.cmd.colorscheme('everforest')
    end
  },

  --  { 'feline-nvim/feline.nvim', branch = '0.5-compat' },
  { 'nvim-lualine/lualine.nvim',
    lazy = true,
    config = function()
      require "lualine".setup {
        options = { theme = "everforest" },
        sections = {
          lualine_c = { "filename", require "pomodoro".statusline },
        },
      }
    end
  },
  { 'junegunn/fzf',
    lazy = true,
  },
  { 'neovim/nvim-lspconfig',
    lazy = true,
  },
  { 'j-hui/fidget.nvim',
    lazy = true,
    config = function()
      require "fidget".setup {}
    end
  },
  -- 아래 lspsaga와 기능이 겹친다. { "ii14/lsp-command" },
  {
    "glepnir/lspsaga.nvim",
    lazy = true,
    event = "BufRead",
    config = function()
      require("lspsaga").setup({})
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } }
  },
  -- { "ray-x/lsp_signature.nvim",
  --   config = function()
  --     require "lsp_signature".setup(lsp_signature_cfg)
  --   end,
  --   keys = {
  --     { '<C-k>',
  --       function() require('lsp_signature').toggle_float_win() end,
  --       { silent = true, noremap = true, desc = 'toggle signature' }
  --     },
  --     { '<Leader>k',
  --       function() vim.lsp.buf.signature_help() end,
  --       { silent = true, noremap = true, desc = 'toggle signature' }
  --     }
  --  }
  -- },
  --  { "folke/neoconf.nvim", cmd = "Neoconf" },
  { "folke/neodev.nvim",
    lazy = true,
  },
  -- 특정 기호등을 기준으로 정렬할 때 쓴다.
  -- :Tabularize /= (이렇게 하면 =을 기준으로 정렬된다.)
  { 'godlygeek/tabular',
    lazy = true,
  },
  { 'preservim/vim-markdown',
    lazy = true,
  },
--  { 'EdenEast/nightfox.nvim', branch = 'main' },
  { 'marko-cerovac/material.nvim',
    lazy = true,
  },
  { 'purescript-contrib/purescript-vim', branch = 'main',
    lazy = true,
  },
  { 'vmchale/dhall-vim',
    lazy = true,
  },
  { 'iamcco/markdown-preview.nvim',
    ['do'] = vim.fn['cd app && yarn install']
  },
  --{ 'iamcco/markdown-preview.nvim' },
  { 'MattesGroeger/vim-bookmarks',
    lazy = true,
  },
  { 'kassio/neoterm',
    lazy = true,
  },
  { 'nvim-tree/nvim-web-devicons',
    config = function ()
      require'nvim-web-devicons'.setup{
        default = true,
      }
    end,
  },
  { 'akinsho/bufferline.nvim',
    config = function()
      require("bufferline").setup {}
    end
  },
  { 'nvim-tree/nvim-tree.lua',
    lazy = true,
  },
  { 'itchyny/lightline.vim',
    lazy = true,
  },
  --  { 'antoinemadec/FixCursorHold.nvim' },
  { 'tpope/vim-fugitive',
    lazy = true,
  },
  { 'idanarye/vim-merginal',
    branch = 'develop',
    lazy = true,
  },
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-lua/popup.nvim' },
  { 'numkil/ag.nvim',
    lazy = true,
  },
  { 'duane9/nvim-rg',
    lazy = true,
    branch = 'main',
  },
  { 'nvim-telescope/telescope.nvim',
    lazy = true,
    keys = {
      { '<space>f',
        function()
          return require('telescope.builtin').find_files()
        end, desc = 'Find Files',
      },
      { '<space>g',
        function()
          return require('telescope.builtin').live_grep { search_dirs = { '.' } }
        end, desc = 'Live Grep',
      },
      { '<space>b',
        function()
          return require('telescope.builtin').buffers()
        end, desc = 'Buffers',
      },
      { '<space>s',
        function()
          return require('telescope').extensions.possession.list()
        end, desc = 'Session',
      },
      -- { '<space>p',
      --   function()
      --     return require('telescope').extensions.projects.projects()
      --   end, desc = 'Project',
      -- },
      { '<space>m',
        function()
          return require('telescope').extensions.vim_bookmarks.all()
        end, desc = 'Bookmarks',
      },
    },
    config = function()
      require("telescope").setup({
        extensions = {
          undo = {
            side_by_side = true,
            --layout_strategy = "vertical",
            layout_config = {
              preview_height = 0.8,
            },
          },
        },
      })
      require("telescope").load_extension("undo")
      vim.keymap.set("n", "<Space>u", "<cmd>Telescope undo<cr>", { desc = "Undo" })
      require("telescope").load_extension("possession")
      --require("telescope").load_extension("projects")
      require("telescope").load_extension("file_browser")
      require("telescope").load_extension("vim_bookmarks")
      vim.keymap.set("n", "<Space>r", "<cmd>Telescope resume<cr>", { desc = "Resume" })
    end,
    dependencies = {
      'nvim-telescope/telescope-file-browser.nvim',
      'tom-anders/telescope-vim-bookmarks.nvim',
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
      "nvim-telescope/telescope-media-files.nvim",
    },
  },
  --  { 'tom-anders/telescope-vim-bookmarks.nvim' },
  --  { 'nvim-telescope/telescope-file-browser.nvim' },
  { 'monkoose/fzf-hoogle.vim',
    lazy = true,
  },
  { 'nvim-treesitter/nvim-treesitter',
    ['do'] = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      { 'm-demare/hlargs.nvim',
        config = function()
          require('hlargs').setup()
        end,
      },
    },
  },
  { 'kdheepak/lazygit.nvim',
    branch = 'main',
    lazy = true,
  },
  { 'simrat39/symbols-outline.nvim',
    lazy = true,
  },
  { 'numToStr/Comment.nvim',
    lazy = true,
    config = function()
      require('Comment').setup()
    end,
  },
  { 'nvim-orgmode/orgmode',
    lazy = true,
    config = function()
      require('orgmode').setup_ts_grammar()
      vim.opt.conceallevel = 0
      vim.opt.concealcursor = 'nc'
      require('orgmode').setup({
        org_agenda_files = { '~/notes/*', '~/notes/**/*' },
        org_default_notes_file = '~/notes/refile.org',
      })
    end,
  },
  { 'linty-org/key-menu.nvim',
    lazy = true,
    init = function()
      -- 팝업 keymap
      -- 보통 아는 명령어면 연달아서 입력한다.
      -- 600밀리초 지나도 다음 키가 안들어 오면 메뉴를 띄운다.
      -- vim.o.timeoutlen = 1200
      require 'key-menu'.set('n', '<leader>')
      require 'key-menu'.set('n', '<Space>')
      require 'key-menu'.set('n', 'g')
      require 'key-menu'.set('n', 's')
      require 'key-menu'.set('n', 't')
      require 'key-menu'.set('n', 'm')
      require 'key-menu'.set('v', 't')
      require 'key-menu'.set('v', 'm')
      vim.keymap.set({ 'n', 'i', 'v' }, '<F1>', function() require 'key-menu'.open_window('') end,
        { desc = 'Key Binding' })
    end
  }, --팝업 메뉴
  { 'kevinhwang91/nvim-bqf',
    lazy = true,
  },
  { 'caenrique/nvim-maximize-window-toggle',
    lazy = true,
  },
  { 'echasnovski/mini.nvim',
    version = '*'
  },
  { 'echasnovski/mini.indentscope',
    version = '*',
    lazy = true,
  },
  { 'echasnovski/mini.surround',
    lazy = true,
    version = '*',
    config = function()
      require('mini.surround').setup {}
    end
  },
  { 'jedrzejboczar/possession.nvim',
    lazy = true,
    config = function()
      require "possession".setup {}
    end
  },
  { "hrsh7th/nvim-cmp",
    lazy = true,
    event = "InsertEnter", --  이 때 로드한다.
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lua",
    },
    init = function()
      -- Set up nvim-cmp.
      -- :CmpStauts로 현재 cmp 상태를 볼 수 있다.
      local cmp = require 'cmp'
      local select_opts = { behavior = cmp.SelectBehavior.Select }

      cmp.setup({
        snippet = {
          -- 여러 스니펫 엔진 중 snippy를 쓴다.
          expand = function(args)
            require('snippy').expand_snippet(args.body)
          end,
        },
        window = {
          --completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          -- false로 하면 반드시 하나를 선택하라 하고,
          -- true로 하면 첫 번째가 선택되어 있는 걸로 간주한다.
          ['<tab>'] = cmp.mapping.select_next_item(select_opts),
          ['<S-tab>'] = cmp.mapping.select_prev_item(select_opts),
        }),

        -- 모두 1차원 배열로 해도 되는데, 묶으면 순서를 지정하는 효과가 있다.
        sources = cmp.config.sources({
          { name = 'path' },
          { name = 'calc' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'nvim_lsp_document_symbol' },
          { name = 'nvim_lua' },
          { name = 'snippy' },
        }, {
          { name = 'buffer' },
        }),
        formatting = {
          fields = { 'menu', 'abbr', 'kind' } -- 우선 순위
        },
      })

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      -- 명령 모드에서도 자동 완성을 쓸 수 있다.
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
      --  todo 아래를 빼내야 한다.
--      local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
    end,
  },
  { 'dcampos/nvim-snippy',
    lazy = true,
  },
  { 'dcampos/cmp-snippy',
    lazy = true,
  },
  { 'kabouzeid/nvim-lspinstall',
    lazy = true,
  },
  { 'williamboman/mason.nvim',
    lazy = true,
    config = function()
      return Config_mason()
    end
    --dependencies = {'mason-lspconfig'}
  },
  { 'williamboman/mason-lspconfig.nvim',
    lazy = true,
  },
  { 'ahmedkhalf/lsp-rooter.nvim',
    lazy = true,
    config = function()
      require "lsp-rooter".setup {}
    end,
  },
  { 'RRethy/vim-illuminate' },
  { 'mattn/webapi-vim' },
  { 'sindrets/diffview.nvim',
    lazy = true,
    config = function()
      require("diffview").setup {}
    end,
  },
  --  { 'petertriho/nvim-scrollbar' },
  --  오른쪽 스크롤러가 내용을 가리는 경우가 있다.
  -- { 'ahmedkhalf/project.nvim',
  --   config = function()
  --     require "project_nvim".setup {}
  --   end,
  -- },
  { 'dstein64/vim-startuptime' },
  { 'wthollingsworth/pomodoro.nvim',
    lazy = true,
    dependencies = { 'MunifTanjim/nui.nvim' },
    config = function()
      require('pomodoro').setup({
        time_work = 25,
        time_break_short = 5,
        time_break_long = 20,
        timers_to_long_break = 4
      })
    end,
  },
  { "jackMort/ChatGPT.nvim",
    lazy = true,
    config = function()
      require "chatgpt".setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    },
  },
  { "hkupty/iron.nvim",
    lazy = true,
    config = function()
      require "iron.core".setup {
        config = {
          scratch_repl = true,
          repl_definition = {
            -- custom repl that loads the current file
            haskell = {
              command = function(meta)
                local filename = vim.api.nvim_buf_get_name(meta.current_bufnr)
                return { 'cabal', 'v2-repl', filename }
              end
            }
          }
        },
        --repl_open_cmd = require"iron.view".bottom(40),
        keymaps = {
          send_motion = "tv",
          visual_send = "tv",
          send_file = "tf",
          send_line = "tl",
          send_mark = "ms",
          mark_motion = "mv",
          mark_visual = "mv",
          remove_mark = "md",
          cr = "t<cr>",
          interrupt = "ti",
          exit = "tq",
          clear = "tc",
        },
        -- If the highlight is on, you can change how it looks
        -- For the available options, check nvim_set_hl
        highlight = {
          italic = true
        },
        ignore_blank_lines = true,
      }
    end,
    keys = {
      { '<space>is', '<cmd>IronRepl<cr>', desc = "Iron Repl" },
      { '<space>ir', '<cmd>IronRestart<cr>', desc = "Iron Restart" },
      { '<space>if', '<cmd>IronFocus<cr>', desc = "Iron Focus" },
      { '<space>ih', '<cmd>IronHide<cr>', desc = "Iron Hide" },
    }
  },

  {
    'echasnovski/mini.starter',
    version = '*',
    config = function()
      require "mini.starter".setup {}
    end,
  },
  {
    'rcarriga/nvim-notify',
    lazy = true,
    config = function()
      require "notify".setup {}
      require('telescope').load_extension("notify")
    end,
  },
  {
    'folke/trouble.nvim',
    lazy = true,
    config = function()
      require "trouble".setup()
    end,
  },
  -- { -- 아래 textsubjects와 기능이 겹친다.
  --   'David-Kunz/treesitter-unit',
  --   config = function()
  --     vim.api.nvim_set_keymap('x', 'iu', ':lua require"treesitter-unit".select()<CR>', { noremap = true })
  --     vim.api.nvim_set_keymap('x', 'au', ':lua require"treesitter-unit".select(true)<CR>', { noremap = true })
  --     vim.api.nvim_set_keymap('o', 'iu', ':<c-u>lua require"treesitter-unit".select()<CR>', { noremap = true })
  --     vim.api.nvim_set_keymap('o', 'au', ':<c-u>lua require"treesitter-unit".select(true)<CR>', { noremap = true })
  --   end,
  -- },
  {
    'RRethy/nvim-treesitter-textsubjects',
    config = function()
      require('nvim-treesitter.configs').setup {
        textsubjects = {
          enable = true,
          prev_selection = ',', -- (Optional) keymap to select the previous selection
          keymaps = {
            ['<cr>'] = 'textsubjects-smart', -- 디폴트는 .으로 되어 있다.
            [';'] = 'textsubjects-container-outer',
            ['i;'] = 'textsubjects-container-inner',
          },
        },
      }
    end,
  },
  {
    'norcalli/nvim-colorizer.lua',
    lazy = true,
    config = function()
      require 'colorizer'.setup()
    end,
  },
  {
    'kevinhwang91/nvim-hlslens',
    lazy = true,
    config = function()
      require('hlslens').setup()
    end,
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require("nvim-autopairs").setup {}
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require("nvim-ts-autotag").setup {}
    end,
  },
  {
    'mfussenegger/nvim-dap',
    lazy = true,
    config = function()
      vim.api.nvim_set_keymap(
        'n', '<F8>', [[:lua require"dapui".toggle()<CR>]],
        { noremap = true })
      vim.api.nvim_set_keymap(
        'n', '<F9>', [[:lua require"dap".toggle_breakpoint()<CR>]],
        { noremap = true })
      vim.api.nvim_set_keymap(
        'n', '<F5>', [[:lua require"dap".continue()<CR>]],
        { noremap = true })
      vim.api.nvim_set_keymap(
        'n', '<F10>', [[:lua require"dap".step_over()<CR>]],
        { noremap = true })
      vim.api.nvim_set_keymap(
        'n', '<F11>', [[:lua require"dap".step_into()<CR>]],
        { noremap = true })
      vim.api.nvim_set_keymap(
        'n', '<F12>', [[:lua require"dap.ui.widgets".hover()<CR>]],
        { noremap = true })
      vim.api.nvim_set_keymap(
        'n', '<F4>', [[:lua require"dap".repl.open()<CR>]],
        { noremap = true })

      local workspaceFolder = vim.fn.getcwd()
      local dap = require "dap"

      dap.adapters.haskell = {
        type = 'executable';
        command = 'haskell-debug-adapter';
        args = { '--hackage-version=0.0.38.0' };
      }
      dap.configurations.haskell = {
        {
          type = 'haskell',
          request = 'launch',
          name = 'haskell-debug-adapter',
          program = "${file}",
          workspace = "${workspaceFolder}",
          -- 이걸 매 번 지정해줘야 하는 걸까?
          --startup = "${workspaceFolder}/test/Spec.hs",
          startup = "${workspaceFolder}/app/Main.hs",
          startupFunc = "",
          startupArgs = "",
          stopOnEntry = false,
          mainArgs = "",
          logFile = vim.fn.stdpath('cache') .. '/haskell-dap.log',
          logLevel = 'WARNING',
          ghciEnv = vim.empty_dict(),
          ghciPrompt = "H>>= ",
          -- 아래 stack ghci 명령어를 실행했을 때 ghci에서 보이는 프롬프트로 수정해야 한다.
          ghciInitialPrompt = "ghci> ",
          ghciCmd = "stack ghci --with-ghc=haskell-dap --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show",
        },
      }
    end
  },
  -- neovim lua 설정, 디버거로 neovim 자체를 쓴다.
  -- neovim lua만 특별히 독립 플러그인으로 설정하고,
  -- 다른 언어는 위에 nvim-dap 설정을 이용하자.
  {
    'jbyuki/one-small-step-for-vimkind',
    lazy = true,
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      require "dap".configurations.lua = {
        {
          type = 'nlua',
          request = 'attach',
          name = "Attach to running Neovim instance",
        }
      }
      require "dap".adapters.nlua = function(callback, config)
        callback({
          type = 'server',
          host = config.host or "127.0.0.1",
          port = config.port or 8086
        })
      end
      vim.api.nvim_set_keymap(
        'n', '<S-F5>', [[:lua require"osv".launch({port = 8086})<CR>]],
        { noremap = true })
    end
  },
  {
    'rcarriga/nvim-dap-ui',
    lazy = true,
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function ()
      require("dapui").setup()
    end,
  },
  {
    'TimUntersberger/neogit',
    config = function ()
      require "neogit".setup {}
    end,
    lazy = false,
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
})

--[[
-- Runghc, StackBuild, GHCI는 미리 Terminal이 열려있어야 한다.
-- 아직, 빌드 환경 설정을 찾지 못해 임시로 만들었다.
function Runghc()
  local w = vim.fn.win_getid()
  vim.cmd.write()
  vim.cmd(':T runghc %')
  vim.fn.win_gotoid(w)
end

function StackBuild()
  local w = vim.fn.win_getid()
  vim.cmd.write()
  vim.cmd(':T stack run')
  vim.fn.win_gotoid(w)
end

function GHCI()
  vim.cmd(':TREPLSendFile')
end

vim.keymap.set({ 'n', 'v', 'i' }, '<F5>', function() return Runghc() end, { desc = 'ghc' })
vim.keymap.set({ 'n', 'v', 'i' }, '<F6>', function() return StackBuild() end, { desc = 'stack build' })
vim.keymap.set({ 'n', 'v', 'i' }, '<F7>', function() return GHCI() end, { desc = 'ghci' })
 ]]
require 'nvim-treesitter.configs'.setup {
  autotag = {
    enable = true,
  },
  ensure_installed = { "haskell", "lua", "javascript", "typescript", "vim", "rust", "python", "graphql", "html", "css",
    "json" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false로 하면 모든 확장을 비활성화
    disable = { "" }, -- TS를 비활성화할 언어 목록
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = { 'org' }, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
  },
  indent = { enable = true },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        -- 디폴트로 ip (inner paragraph), ap (a paragraph) 기능이 있다.
        -- 아직은 제대로 동작하지 않을 때가 있는 것 같다.
        -- lua 파일에서는 `function` 키워드를 찾아서 동작한다.
        ["af"] = { query = "@function.outer", desc = "Select function outer" },
        ["if"] = { query = "@function.inner", desc = "Select function inner" },
        ["ac"] = { query = "@comment.outer", desc = "Select comment outer" },
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
      },
      selection_modes = {
        ['@comment.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      include_surrounding_whitespace = true,
    },
    lsp_interop = {
      enable = true,
      border = 'none',
      peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dF"] = "@class.outer",
      },
    },
  },
}


local outline_opts = {
  highlight_hovered_item = true,
  show_guides = true,
  auto_preview = false,
  position = 'right',
  relative_width = true,
  width = 25,
  auto_close = false,
  show_numbers = false,
  show_relative_numbers = false,
  show_symbol_details = true,
  preview_bg_highlight = 'Pmenu',
  autofold_depth = 0,
  auto_unfold_hover = true,
  fold_markers = { '', '' },
  wrap = false,
  keymaps = { -- These keymaps can be a string or a table for multiple keys
    --close = { "<Esc>", "q" }, -- 자꾸 ESC를 눌러서 닫아 버린다.
    close = { "q" }, -- 이래도 ESC로 닫힌다.
    goto_location = "<Cr>",
    focus_location = "o",
    hover_symbol = "<C-k>",
    toggle_preview = "K",
    rename_symbol = "r",
    code_actions = "a",
    fold = "h",
    unfold = "l",
    fold_all = "W",
    unfold_all = "E",
    fold_reset = "R",
  },
  lsp_blacklist = {},
  symbol_blacklist = {},
  symbols = {
    File = { icon = "", hl = "TSURI" },
    Module = { icon = "", hl = "TSNamespace" },
    Namespace = { icon = "", hl = "TSNamespace" },
    Package = { icon = "", hl = "TSNamespace" },
    Class = { icon = "𝓒", hl = "TSType" },
    Method = { icon = "ƒ", hl = "TSMethod" },
    Property = { icon = "", hl = "TSMethod" },
    Field = { icon = "", hl = "TSField" },
    Constructor = { icon = "", hl = "TSConstructor" },
    Enum = { icon = "ℰ", hl = "TSType" },
    Interface = { icon = "ﰮ", hl = "TSType" },
    Function = { icon = "", hl = "TSFunction" },
    Variable = { icon = "", hl = "TSConstant" },
    Constant = { icon = "", hl = "TSConstant" },
    String = { icon = "𝓐", hl = "TSString" },
    Number = { icon = "#", hl = "TSNumber" },
    Boolean = { icon = "⊨", hl = "TSBoolean" },
    Array = { icon = "", hl = "TSConstant" },
    Object = { icon = "⦿", hl = "TSType" },
    Key = { icon = "🔐", hl = "TSType" },
    Null = { icon = "NULL", hl = "TSType" },
    EnumMember = { icon = "", hl = "TSField" },
    Struct = { icon = "𝓢", hl = "TSType" },
    Event = { icon = "🗲", hl = "TSType" },
    Operator = { icon = "+", hl = "TSOperator" },
    TypeParameter = { icon = "𝙏", hl = "TSParameter" }
  }
}

require("symbols-outline").setup(outline_opts)
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
    highlight_git = true,
  },
  filters = {
    dotfiles = true,
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
})

vim.keymap.set({ 'n', 'v' }, '<C-n>', ':NvimTreeFindFileToggle!<CR>', { silent = true })
--vim.keymap.set({'n','v'}, '<C-n>', ':CHADopen --always-focus<CR>',{silent=true})

vim.keymap.set({ 'n', 'i', 'v' }, '<F2>', ':cd %:h<CR>', { desc = 'Change Current Directory' })
-- 아래처럼 메뉴를 지정해도 된다.
--vim.keymap.set('n', '<Space>o',
--  function() require 'key-menu'.open_window('<leader>o') end, {desc='Orgmode'})

-- 어느 플러그인에선가 바꾸고 있는 것 같다. 첫부분에 써주면 작동 안하는데,
-- 마지막에 써주면 작동한다.
set.guicursor = 'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175'
-- 이게 디폴트 설정인데, mark 관련 플러그인이 가져가나 보다.
-- <C-h>를 BS로 쓰려면 아래로 설정해야 한다.
-- Coq이 로딩할때 가져 가는 것으로 보인다.
vim.keymap.set({ 'i' }, '<C-h>', '<BS>', { silent = true, noremap = true })

-- mini.indentscope
require('mini.indentscope').setup(
-- No need to copy this inside `setup()`. Will be used automatically.
  {
    draw = {
      delay = 100,
      -- Animation rule for scope's first drawing. A function which, given
      -- next and total step numbers, returns wait time (in ms). See
      -- |MiniIndentscope.gen_animation()| for builtin options. To disable
      -- animation, use `require('mini.indentscope').gen_animation('none')`.
      animation = function(_ , _)
        return 20
      end,
    },
    -- Module mappings. Use `''` (empty string) to disable one.
    -- 괄호 안의 오브젝트를 골라내는데 treesitter-unit을 쓰고 있다.
    -- 아래는 treesitter의 오브젝트 하일라이트 기능을 찾으면 삭제할 것
    mappings = {
      -- Textobjects
      object_scope = 'ii',
      object_scope_with_border = 'ai',
      -- Motions (jump to respective border line; if not present - body line)
      goto_top = '[i',
      goto_bottom = ']i',
    },
    -- Options which control scope computation
    options = {
      -- Type of scope's border: which line(s) with smaller indent to
      -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
      border = 'both',
      -- Whether to use cursor column when computing reference indent.
      -- Useful to see incremental scopes with horizontal cursor movements.
      indent_at_cursor = true,
      -- Whether to first check input line to be a border of adjacent scope.
      -- Use it if you want to place cursor on function header to get scope of
      -- its body.
      try_as_border = true,
    },
    -- Which character to use for drawing scope indicator
    symbol = '╎',
  }
)

set.completeopt = { 'menu', 'menuone', 'noselect' }

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
-- 찾기 모드에서도 자동 완성을 쓸 수 있다.
-- lua LSP서버가 글로벌 vim 변수가 없는 것으로 인식한다.
-- 이를 해결하기 위해 아래 globals를 추가


vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

-- tree-sitter로 폴딩을 자동으로 만드는 것까진 좋은데, 디폴트로 모두 close 상태다.
-- 이를 처음 파일을 열면 열어두기 위해 아래 방법을 쓴다.
vim.api.nvim_create_autocmd(
  { "BufReadPost", "FileReadPost" },
  { pattern = "*",
    command = "normal zR"
  }
)

--require("scrollbar").setup{} -- 오른쪽 끝의 텍스트를 가리는 경우가 있다.
--require('feline').setup {}

-- LSP의 Capabilities란?
-- LSP서버는 클라이언트 능력Capabilities에 따라 다른 자동완성completion 결과를 제공한다.
-- Neovim의 디폴트 omnifunc는 기본으로 자동완성 제안을 보여준다.
-- nvim-cmp는 더 많은 타입의 자동완성 제안을 지원한다.
--
