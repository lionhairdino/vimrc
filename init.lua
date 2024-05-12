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
--
--vim.loader.enable()

local set = vim.opt
set.mouse = "ar"
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
set.conceallevel = 2

-- v0.9로 올리고 나서 아래 프린터 설정은 모두 없는 것으로 나온다.
--set.printencoding = 'utf8'
--set.printmbcharset = 'ISO10646'
--set.printmbfont = 'r:D0CodingLigature,c:yes,a:yes'
--#set.printfont = 'D2CodingLigature:h10'
--set.printdevice = 'FUJI_XEROX_DocuPrint_CP225_228_w_'
--set.printdevice = 'HP-LaserJet-1200'
--set.timeoutlen = 300
set.termguicolors = true
--set.updatetime = 1200 -- nvim_create_autocmd에서 사용
------ Nvim-tree
-- 기본 탐색기 끄기
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- 디폴트 filetype.vim을 안쓰기
-- neovim 0.6이전만 아래를 추가하란다.
-- vim.g.did_load_filetypes = 1

vim.g['oceanic_next_terminal_bold'] = 1
vim.g['oceanic_next_terminal_italic'] = 1

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
vim.g['mkdp_theme'] = 'light' -- markdown preview 플러그인 테마 설정
vim.g['mkdp_filetypes'] = { "markdown" }
-- 편집할 때 마크다운 태그를 일부 적용해서 보여준다.
-- **Bold** 는 **없이 Bold체로 보여준다.
-- :set conceallevel=2 와 같다.
vim.g['vim_markdown_conceal'] = 2
vim.g['vim_markdown_folding_disabled'] = 1
vim.g['vim_markdown_toc_autofit'] = 1
vim.g['vim_markdown_no_default_key_mappings'] = 1 -- 디폴트 키매핑 사용안함
--vim.cmd.colorscheme('OceanicNext')
--vim.g.material_style = "oceanic-next"
-- 터미널에 포커스가 가면 자동으로 입력모드
-- vim.api.nvim_create_autocmd(
--   { "BufWinEnter", "WinEnter" },
--   { pattern = "term://*",
--     command = "startinsert" }
-- )
-- vim.g['nvimhsPluginStarter']='nvimhs#stack#pluginistarter()' 디폴트 값이 이거다. 불필요
vim.diagnostic.config({ virtual_text = true })

-- 점프키와 충돌
vim.keymap.set({ 'n' }, '<Tab>', ':bn<CR>', { silent = true })
vim.keymap.set({ 'n' }, '<S-Tab>', ':bp<CR>', { silent = true })
vim.keymap.set({ 'n' }, 'k', 'gk', { silent = true })
vim.keymap.set({ 'n' }, 'j', 'gj', { silent = true })

-- Shift-BS는 작동하지 않고 있다. 이유는 아직 모른다.
-- GUI에서만 지정 가능한 키조합이라 한다.
--
--vim.keymap.set({ 'i' }, '<c-h>', '<Left>', { silent = true })
vim.keymap.set({ 'i' }, '<c-h>', '<bs>', { silent = true })
--vim.keymap.set({ 'i' }, '<c-j>', '<Down>', { silent = true })
vim.keymap.set({ 'i' }, '<c-k>', '<Up>', { silent = true })
vim.keymap.set({ 'i' }, '<c-l>', '<Right>', { silent = true })
vim.keymap.set({ 'i' }, '<c-j>', '<c-o>A<cr>', { silent = true })
--vim.keymap.set({ 'i' }, '<Shift-BS>', '<kDel>', { silent = true })
vim.keymap.set({ 'i', 'n', 'v' }, '<C-\\>', ':ToggleTerm<CR>', { silent = true })

vim.keymap.set('n', '<F3>', ':Neogit kind=split<CR>', { desc = 'Git' })

-- 윈도우 크기 조절
vim.keymap.set('n', '=', ':resize +5<CR>', { desc = 'incresing height', silent = true })
vim.keymap.set('n', '-', ':resize -5<CR>', { desc = 'incresing height', silent = true })
vim.keymap.set('n', '+', ':vertical resize +5<CR>', { desc = 'incresing width', silent = true })
vim.keymap.set('n', '_', ':vertical resize -5<CR>', { desc = 'incresing width', silent = true })

vim.keymap.set({ 'n', 'v' }, 'S', ':lua surround_with_text()<CR>', { desc = 'surround with text', silent = false })

vim.keymap.set({ 'v' }, '<c-j>', ':lua send_to_terminal()<CR>', { desc = 'send to terminal', silent = true })

vim.keymap.set({ 'i', 'n', 'v' }, '<Insert>',
  '<Cmd>lua if vim.opt.background:get() == "dark" then vim.opt.background = "light" else vim.opt.background = "dark" end<CR>',
  { silent = false })
-- Yank하면 잠시 색깔 바꾸기
vim.api.nvim_exec([[
  augroup VisualModeHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank({ timeout = 1000 })
  augroup END
]], false)

vim.api.nvim_exec([[
  augroup HoogleMaps
    autocmd!
    autocmd FileType haskell setlocal keywordprg=:Hoogle
  augroup END
]], false)
vim.g['hoogle_fzf_window'] = { down = '50%' }

-- lua 파일일 경우 `k`단축키로 헬프 찾도록
vim.api.nvim_exec([[
  augroup SetKeywordprgForLua
    autocmd!
    autocmd BufRead,BufNewFile *.lua setlocal keywordprg=:help
  augroup END
]], false)

-- 터미널에 떠있는 ghci에게 멀티라인 코드 보내기
function send_to_terminal()
  local term_win_id = vim.fn.bufwinid('#toggleterm#')
  if term_win_id == -1 then
    vim.fn.execute("ToggleTerm")
    term_win_id = vim.fn.bufwinid('#toggleterm#')
    vim.fn.execute("TermExec cmd=\"ghci\"")
  end
  vim.fn.execute("TermExec cmd=\":\\{\"")

  --vim.fn.execute("'<,'>ToggleTermSendVisualSelection")
  require("toggleterm").send_lines_to_terminal("visual_lines", false, { args = vim.v.count })

  vim.fn.execute("TermExec cmd=\":\\}\"")
  vim.api.nvim_set_current_win(term_win_id)
  vim.fn.execute("normal! i")
end

function surround_with_text()
  local t = vim.fn.input("wrap> ")
  vim.fn.execute("normal! `>a<CR>" .. t)
  vim.fn.execute("normal! `<i" .. t .. "<CR>")
end

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


function Gmarks()
  local extmarks = vim.api.nvim_buf_get_extmarks(0, -1, 0, -1, { details = true })
  -- 결과 출력
  for _, extmark in ipairs(extmarks) do
    vim.print(extmark)
  end
end

--
--vim.g.mapleader = " " -- make sure to set `mapleader` before lazy so your mappings are correct
--<Leader> 키를 지정하는 것 같다.

local function lsp_on_attach_keysetup(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local bufopts = { noremap = true, silent = false, buffer = bufnr }
  --vim.keymap.set('n', 'K', ':lua vim.lsp.buf.hover()<CR>', bufopts)
  -- 정의부가 이미 스플릿된 다른창에 있는 소스에 있으면, 현재 창에서 정의부로 점프하지 않고,
  -- 열려 있는 창으로 포커싱이 이동되게 하려면 reuse 옵션을 쓴다.
  -- 그런데, 문제는 돌아 올때다. 스플릿된 다른 창으로 갔다가 c-o를 누르면 원래 창으로
  -- 돌아오지 못하고, 그 창에 버퍼를 바꿔버린다.
  --vim.keymap.set('n', '<C-]>', ':lua vim.lsp.buf.definition{ reuse_win = true } <CR>', bufopts)
  vim.keymap.set('n', '<C-]>', ':lua vim.lsp.buf.definition()<CR>', bufopts)
  vim.keymap.set('n', 'gA', ':lua vim.lsp.buf.code_action()<CR>', bufopts)
  vim.keymap.set('n', 'gh', ':lua vim.lsp.buf.hover()<CR>', bufopts)
  vim.keymap.set('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', bufopts)
  vim.keymap.set('n', 'gD', ':lua vim.lsp.buf.type_definition()<CR>', bufopts)
  vim.keymap.set('n', 'gw', ':lua vim.lsp.buf.workspace_symbol()<CR>', bufopts)
  vim.keymap.set('n', 'go', ':lua vim.diagnostic.open_float()<CR>', bufopts)
  vim.keymap.set('n', 'g[', ':lua vim.lsp.diagnostic.goto_prev()<CR>', bufopts)
  vim.keymap.set('n', 'g]', ':lua vim.lsp.diagnostic.goto_next()<CR>', bufopts)
  vim.keymap.set('n', 'gl', ':lua vim.diagnostic.setloclist()<CR>', bufopts)
  vim.keymap.set('n', 'gr', ':lua vim.lsp.buf.references()<CR>', bufopts)
  vim.keymap.set('n', 'gO', ':lua vim.lsp.buf.format{ async=true }<CR>', bufopts)
  vim.keymap.set('n', 'gR', ':lua vim.lsp.buf.rename()<CR>', bufopts)
  vim.keymap.set('n', 'gs', ':lua vim.lsp.codelens.refresh()<CR>', bufopts)
  vim.keymap.set('n', 'ge', ':lua vim.lsp.codelens.run()<CR>', bufopts)
end

local function lsp_on_attach(client, bufnr)
  lsp_on_attach_keysetup(client, bufnr);
  -- 매핑이 제대로 동작하는지 nvim 안에서 :map gd 등을 입력해서 알 수 있다.
  vim.opt_local.signcolumn = 'yes' -- 줄번호 왼쪽에 컬럼 하나를 둬서 W,H등을 표시하는 걸 말한다.
  -- vim.api.nvim_create_autocmd(
  --   { "BufEnter", "InsertLeave" },
  --   { pattern = { "*" },
  --     callback = function()
  --       vim.lsp.codelens.refresh()
  --     end
  --   }
  -- )

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

local function Config_mason()
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
    exclude = { "hls" },
  }
  require("mason-lspconfig").setup_handlers {
    -- 키 없이 첫 번째로 정의한 함수는, 지정 핸들러가 없을 경우 쓰이는
    -- 디폴트 핸들러이다.
    function(server_name) -- default handler (optional)
      require("lspconfig")[server_name].setup { on_attach = lsp_on_attach }
    end,

    -- ["hls"] = function()
    --   require 'lspconfig'.hls.setup({
    --     --cmd = { "haskell-language-server-wrapper", "--lsp", "--debug" },
    --     cmd = { "haskell-language-server-wrapper", "--lsp" },
    --     filetypes = { "haskell", "lhaskell", "cabal" },
    --     codeLens = { enabale = true },
    --     on_attach = lsp_on_attach,
    --     --        capabilities = lsp_capabilities,
    --     settings = {
    --       haskell = {
    --         hlintOn = true,
    --         formattingProvider = "stylish-haskell",
    --       }
    --     }
    --   })
    -- end,
    --
    ["lua_ls"] = function()
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
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
            completion = {
              callSnippet = "Replace"
            },
          },
        },
      })
    end,
  }
end

-- :%는 1,$ 즉 전체 파일을 의미한다.
-- :h는 파일 이름에서 head부분을 의미한다.
--
vim.keymap.set({ 'n', 'i', 'v' }, '<F2>', ':cd %:h<CR>', { desc = 'Change Current Directory' })
-- 아래처럼 메뉴를 지정해도 된다.
--vim.keymap.set('n', '<Space>o',
--  function() require 'key-menu'.open_window('<leader>o') end, {desc='Orgmode'})

-- 이게 디폴트 설정인데, mark 관련 플러그인이 가져가나 보다.
-- <C-h>를 BS로 쓰려면 아래로 설정해야 한다.
-- Coq이 로딩할때 가져 가는 것으로 보인다.
-- vim.keymap.set({ 'i' }, '<C-h>', '<BS>', { silent = true, noremap = true })
-- 커서 이동키에 h를 바인딩했다.

-- mini.indentscope


-- set.completeopt = { 'menu', 'menuone', 'noselect' }
-- #1442를 보면 설정하지 말라도 되어 있다.

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
-- 찾기 모드에서도 자동 완성을 쓸 수 있다.
-- lua LSP서버가 글로벌 vim 변수가 없는 것으로 인식한다.
-- 이를 해결하기 위해 아래 globals를 추가


-- vim.wo.foldmethod = "expr"
-- vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

-- tree-sitter로 폴딩을 자동으로 만드는 것까진 좋은데, 디폴트로 모두 close 상태다.
-- 이를 처음 파일을 열면 열어두기 위해 아래 방법을 쓴다.
-- vim.api.nvim_create_autocmd(
--   { "BufReadPost", "FileReadPost" },
--   { pattern = "*",
--     command = "normal zR|cd %:h" -- 폴더 열고, Current 디렉토리 바꾸고
--   }
-- )

-- :lcd, :tcd 를 이용하도록 바꿨다.
-- vim.api.nvim_create_autocmd(
--   { "BufRead" },
--   { pattern = "*",
--     command = "cd %:h" -- 폴더 열고, Current 디렉토리 바꾸고
--   }
-- )
--

-- Lazy 플러그인 사용법
-- opts: 아래 config에서 쓸 옵션 테이블
-- config: 플러그인이 로드될 때 실행된다. 기본 구현은 require(Main).setup(opts)를 실행한다.
--          사용자가 특별히 지정할 옵션이 없을 땐 config = true로 주면 require(Main).setup()을 실행한다.
-- init: 시작할 때 실행. 플러그인 시작인가? nvim 시작인가?

local plugins = {
  {
    'sainnhe/everforest',
    lazy = false,
    config = function()
      vim.cmd.colorscheme('everforest')
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    event = { 'VimEnter' },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'linrongbin16/lsp-progress.nvim'
    },
    config = function()
      require "lualine".setup {
        options = { theme = "everforest" },
        sections = {
          lualine_c = { "filename"
          --, require('NeoComposer.ui').status_recording
          , require "pomodoro".statusline
          , require "lsp-progress".progress
          },
        },
      }
    end

  },
  {
    'linrongbin16/lsp-progress.nvim',
    event = { 'VimEnter' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lsp-progress').setup()
    end
  },
  {
    'junegunn/fzf',
    lazy = true,
    cmd = "FZF",
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup({})
    end
  },
  {
    'j-hui/fidget.nvim',
    -- tag = 'legacy',
    lazy = true,
    config = function()
      require "fidget".setup {
        --        tag = "legacy"
      }
    end
  },
  -- {
  --   'mrded/nvim-lsp-notify',
  --   requires = { 'rcarriga/nvim-notify' },
  --   config = function()
  --     require('lsp-notify').setup({
  --       notify = require('notify'),
  --     })
  --   end,
  --   dependencies = { {"rcarriga/nvim-notify"}}
  -- },
  -- 아래 lspsaga와 기능이 겹친다. { "ii14/lsp-command" },
  -- {
  --   "glepnir/lspsaga.nvim",
  --   lazy = true,
  --   event = "BufRead",
  --   config = function()
  --     require("lspsaga").setup({
  --       ui = {
  --         lightbulb = {
  --           enable = false,
  --         }
  --       }
  --     })
  --   end,
  --   dependencies = { { "nvim-tree/nvim-web-devicons" } }
  -- },
  {
    "folke/neoconf.nvim",
    lazy = true,
    priority = 100,
    config = true,
  },

  {
    "folke/neodev.nvim",
    lazy = true,
    config = true,
    priority = 100,
    dependencies = { "hrsh7th/nvim-cmp" }
  },
  {
    'neovim/nvim-lspconfig',
    priority = 50,
    lazy = true,
  },
  -- 특정 기호등을 기준으로 정렬할 때 쓴다.
  -- :Tabularize /= (이렇게 하면 =을 기준으로 정렬된다.)
  {
    'godlygeek/tabular',
    cmd = "Tabularize",
    lazy = true,
  },
  -- {
  --   'preservim/vim-markdown',
  --   ft = { "md", "markdown" },
  --   lazy = true,
  --   dependencies = { 'godlygeek/tabular' },
  -- },
  --  { 'EdenEast/nightfox.nvim', branch = 'main' },
  {
    'ixru/nvim-markdown',
    ft = { "md", "markdown" },
    lazy = true,
    config = function()

    end
  },
  {
    'marko-cerovac/material.nvim',
    lazy = false,
  },
  {
    'purescript-contrib/purescript-vim',
    branch = 'main',
    ft = "purescript",
    lazy = true,
  },
  {
    'vmchale/dhall-vim',
    ft = { "dhall" },
    lazy = true,
  },
  {
    'iamcco/markdown-preview.nvim',
    lazy = true, -- markdown 파일일 때 활성화가 안된다. 됐었는데, Lazy로 옮기고 안된다.
    ft = { "markdown", "md" },
    build = 'cd app && yarn install',
  },
  {
    'MattesGroeger/vim-bookmarks',
    lazy = true,
    cmd = "BookmarkToggle",
    keys = {
      {
        'mm',
        mode = { "n", "v" },
        ':BookmarkToggle<CR>',
        silent = true,
        desc = "Bookmark"
      },
    },

  },
  { 'akinsho/toggleterm.nvim', version = "*", config = true },
  -- { 'kassio/neoterm',
  --   cmd = 'Tnew',
  --   lazy = true,
  -- },
  {
    'nvim-tree/nvim-web-devicons',
    config = function()
      require 'nvim-web-devicons'.setup {
        default = true,
      }
    end,
  },
  {
    'akinsho/bufferline.nvim',
    config = function()
      require("bufferline").setup {
        mode = tabs
      }
    end,
    dependencies = 'nvim-tree/nvim-web-devicons',
  },
  -- { 'nvim-tree/nvim-tree.lua',
  --   lazy = false,
  --   config = function()
  --     require("nvim-tree").setup {
  --       tab = {
  --         sync = {
  --           open = true,
  --         }
  --       },
  --       sync_root_with_cwd = true,
  --     }
  --   end,
  --   keys = {
  --     {
  --       '<leader>t',
  --       ':NvimTreeFindFileToggle!<CR>',
  --       mode = { 'n', 'v' },
  --       silent = true,
  --       desc = "Nvim-Tree"
  --     },
  --   },
  -- },
  { 'nvim-lua/plenary.nvim',
  },
  { 'nvim-lua/popup.nvim' },
  {
    'numkil/ag.nvim',
    lazy = true,
    cmd = 'Ag'
  },
  {
    'duane9/nvim-rg',
    lazy = true,
    branch = 'main',
    cmd = "Rg",
  },
  {
    "smartpde/telescope-recent-files",
    lazy = true,
    keys = {
      {
        '<space>r',
        function()
          return require('telescope').extensions.recent_files.pick()
        end,
        desc = 'Recent File',
      },
    },

    config = function()
      require("telescope").load_extension("recent_files")
    end,
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
  },

  -- { 'nvim-telescope/telescope-file-browser.nvim',
  --   lazy = true,
  --   keys = {
  --     { '<space>f',
  --       function()
  --         return require('telescope').extensions.file_browser.file_browser()
  --       end, desc = 'File Browser',
  --     },
  --   },
  --   config = function()
  --     require("telescope").load_extension("file_browser")
  --     require("telescope").setup({
  --       extensions = {
  --         file_browser = {
  --           theme = "ivy",
  --         },
  --       },
  --     })
  --   end,
  --   dependencies = {
  --     'nvim-telescope/telescope.nvim',
  --   },
  -- },
  {
    'tom-anders/telescope-vim-bookmarks.nvim',
    lazy = true,
    keys = {
      {
        '<space>m',
        function()
          return require('telescope').extensions.vim_bookmarks.all()
        end,
        desc = 'Bookmarks',
      },
    },
    config = function()
      require("telescope").load_extension("vim_bookmarks")
    end,
    dependencies = {
      'MattesGroeger/vim-bookmarks',
      'nvim-telescope/telescope.nvim',
    },
  },
  {
    "debugloop/telescope-undo.nvim",
    lazy = true,
    keys = {
      { '<space>u', "<cmd>Telescope undo<cr>", desc = "Undo" },
    },

    config = function()
      require("telescope").load_extension("undo")
      require("telescope").setup({
        extensions = {
          undo = {
            side_by_side = true,
            layout_config = {
              preview_height = 0.8,
            },
          },
        },
      })
    end,
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    lazy = true,
    cmd = "Telescope",
    keys = {
      {
        '<space>g',
        function()
          return require('telescope.builtin').live_grep { search_dirs = { '.' } }
        end,
        desc = 'Live Grep',
      },
      {
        '<space>b',
        function()
          return require('telescope.builtin').buffers()
        end,
        desc = 'Buffers',
      },
      {
        '<space>c', "<cmd>Telescope resume<cr>", desc = "Resume"
      },
    },
    config = function()
      require("telescope").setup({
        defaults = require "telescope.themes".get_ivy({}),
        -- You dont need to set any of these options. These are the default ones. Only
        -- the loading is important
        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
          },
        }
      })
      require('telescope').load_extension('fzf')
      --require('telescope').load_extension('macros')
      vim.keymap.set({ 'n' }, '<space>f', ':Telescope find_files<CR>', { silent = true })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      --"kkharji/sqlite.lua",
    },
  },
  -- {
  --   "ecthelionvi/NeoComposer.nvim",
  --   dependencies = { "kkharji/sqlite.lua" },
  --   opts = {}
  -- },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make'
  },
  {
    'monkoose/fzf-hoogle.vim',
    lazy = true,
    cmd = "Hoogle",
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      {
        'm-demare/hlargs.nvim',
        config = function()
          require('hlargs').setup()
        end,
      },
    },
    config = function()
      require 'nvim-treesitter.configs'.setup {
        autotag = {
          enable = true,
        },
        endwise = {
          enable = true,
        },
        ensure_installed = { "haskell", "lua", "javascript", "typescript", "vim", "rust", "python", "graphql", "html",
          "css", "json", "markdown", "http", "json" },   -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        ignore_install = { "" },                         -- List of parsers to ignore installing
        highlight = {
          enable = true,                                 -- false로 하면 모든 확장을 비활성화
          -- disable = { "haskell" },
          disable = { "" },                              -- TS를 비활성화할 언어 목록
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
              ["af"] = { query = "@function.outer", desc = "Select function outer" }, -- v모드에서 af
              ["if"] = { query = "@function.inner", desc = "Select function inner" },
              ["ac"] = { query = "@comment.outer", desc = "Select comment outer" },
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            },
            selection_modes = {
              ['@comment.outer'] = 'v',   -- charwise
              ['@function.outer'] = 'V',  -- linewise
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
    end
  },
  {
    'nvim-treesitter/playground',
    lazy = true,
    cmd = "TSPlaygroundToggle",
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require("nvim-treesitter.configs").setup {
        playground = {
          enable = true,
        }
      }
    end
  },
  -- { 'simrat39/symbols-outline.nvim',
  --   lazy = true,
  --   cmd = "SymbolsOutline",
  --   config = function()
  --     require "symbols-outline".setup({
  --       keymaps = {
  --         --close = { "<Esc>", "q" }, -- 자꾸 ESC를 눌러서 닫아 버린다.
  --         close = { "q" },
  --         goto_location = "<Cr>",
  --         focus_location = "o",
  --         hover_symbol = "<C-k>",
  --         toggle_preview = "K",
  --         rename_symbol = "r",
  --         code_actions = "a",
  --         fold = "h",
  --         unfold = "l",
  --         fold_all = "W",
  --         unfold_all = "E",
  --         fold_reset = "R",
  --       },
  --     })
  --   end,
  -- },
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
  },
  {
    'numToStr/Comment.nvim',
    lazy = true,
    keys = { { "gc", mode = { "v", "n" }, desc = "To Comment" }, { "gb", mode = "v" } },
    config = function()
      require('Comment').setup()
    end,
  },
  -- { 'nvim-orgmode/orgmode',
  --   keys = { { "<leader>oa", "<leader>oc" }, },
  --   lazy = true,
  --   config = function()
  --     require('orgmode').setup_ts_grammar()
  --     vim.opt.conceallevel = 0
  --     vim.opt.concealcursor = 'nc'
  --     require('orgmode').setup({
  --       org_agenda_files = { '~/notes/*', '~/notes/**/*' },
  --       org_default_notes_file = '~/notes/refile.org',
  --     })
  --   end,
  --   dependencies = { 'nvim-treesitter/nvim-treesitter' }
  -- },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      --local wk = require("which-key")
    end,
    opts = { -- 디폴트값을 쓰고 싶지 않다면 여기다 설정
    }
  },
  -- { 'linty-org/key-menu.nvim',
  --   lazy = false,
  --   config = function()
  --     -- 팝업 keymap
  --     -- 보통 아는 명령어면 연달아서 입력한다.
  --     -- 600밀리초 지나도 다음 키가 안들어 오면 메뉴를 띄운다.
  --     -- vim.o.timeoutlen = 1200
  --     require 'key-menu'.set('n', '<leader>')
  --     require 'key-menu'.set('n', '<Space>')
  --     require 'key-menu'.set('n', 'g')
  --     -- require 'key-menu'.set('n', 's')
  --     require 'key-menu'.set('n', 't')
  --     require 'key-menu'.set('n', 'm')
  --     require 'key-menu'.set('v', 't')
  --     require 'key-menu'.set('v', 'm')
  --     vim.keymap.set({ 'n', 'i', 'v' }, '<F1>', function() require 'key-menu'.open_window('') end,
  --       { desc = 'Key Binding' })
  --   end
  -- }, --팝업 메뉴
  -- qickfix 윈도우에서 항목 위에 hover하면 미리보기 창 열기
  -- { 'kevinhwang91/nvim-bqf',
  --   lazy = true,
  --   ft = 'qf',
  -- },
  -- { 'echasnovski/mini.indentscope',
  --   version = '*',
  --   lazy = false,
  --   config = function()
  --     require('mini.indentscope').setup(
  --     -- No need to copy this inside `setup()`. Will be used automatically.
  --       {
  --         draw = {
  --           delay = 100,
  --           -- Animation rule for scope's first drawing. A function which, given
  --           -- next and total step numbers, returns wait time (in ms). See
  --           -- |MiniIndentscope.gen_animation()| for builtin options. To disable
  --           -- animation, use `require('mini.indentscope').gen_animation('none')`.
  --           animation = function(_, _)
  --             return 20
  --           end,
  --         },
  --         -- Module mappings. Use `''` (empty string) to disable one.
  --         -- 괄호 안의 오브젝트를 골라내는데 treesitter-unit을 쓰고 있다.
  --         -- 아래는 treesitter의 오브젝트 하일라이트 기능을 찾으면 삭제할 것
  --         mappings = {
  --           -- Textobjects
  --           object_scope = 'ii',
  --           object_scope_with_border = 'ai',
  --           -- Motions (jump to respective border line; if not present - body line)
  --           goto_top = '[i',
  --           goto_bottom = ']i',
  --         },
  --         -- Options which control scope computation
  --         options = {
  --           -- Type of scope's border: which line(s) with smaller indent to
  --           -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
  --           border = 'both',
  --           -- Whether to use cursor column when computing reference indent.
  --           -- Useful to see incremental scopes with horizontal cursor movements.
  --           indent_at_cursor = true,
  --           -- Whether to first check input line to be a border of adjacent scope.
  --           -- Use it if you want to place cursor on function header to get scope of
  --           -- its body.
  --           try_as_border = true,
  --         },
  --         -- Which character to use for drawing scope indicator
  --         symbol = '╎',
  --       }
  --     )
  --   end
  -- },
  -- { 'echasnovski/mini.surround',
  --   lazy = true,
  --   keys = { { 'sa' }, { 'sd' }, { 'sf' }, { 'sF' }, { 'sh' }, { 'sr' }, { 'sn' } },
  --   version = '*',
  --   config = function()
  --     require('mini.surround').setup {}
  --   end
  -- },
  -- { 'jedrzejboczar/possession.nvim',
  --   lazy = true,
  --   keys = {
  --     {
  --       '<space>s',
  --       function()
  --         return require('telescope').extensions.possession.list()
  --       end,
  --       desc = 'Session',
  --     },
  --   },
  --   config = function()
  --     require("telescope").load_extension("possession")
  --     require "possession".setup {
  --       silent = false,
  --       load_silent = true,
  --       autosave = {
  --         current = true,
  --         tmp = true,
  --         tmp_name = 'tmp',
  --         on_load = true,
  --         on_quit = true,
  --       }
  --     }
  --   end,
  --   cmd = { "PossessionSave", "PossessionLoad" },
  --   dependencies = {
  --     'nvim-telescope/telescope.nvim',
  --   },
  -- },
  {
    "Shatur/neovim-session-manager",
    config = true,
  },
  {
    "coffebar/neovim-project",
    opts = {
      projects = { -- define project roots
        "~/projects/*",
        "~/.config/*",
      },
    },
    init = function()
      vim.opt.sessionoptions:append("globals")
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim", tag = "0.1.5" },
      { "Shatur/neovim-session-manager" },
    },
    priority = 100,
  },
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lua",
      "amarakon/nvim-cmp-lua-latex-symbols",
      "dcampos/nvim-snippy",
      "hrsh7th/cmp-emoji"
    },
    config = function()
      -- Set up nvim-cmp.
      -- :CmpStauts로 현재 cmp 상태를 볼 수 있다.
      local cmp = require 'cmp'
      local select_opts = {
        behavior = cmp.SelectBehavior.Replace,
      }

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
          ['<CR>'] = cmp.mapping.confirm({
            select = false,
          }),
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
          { name = 'emoji' },
          { name = "lua-latex-symbols",       option = { cache = true } },
          { name = 'buffer' },
        }),
        formatting = {
          fields = { 'menu', 'abbr', 'kind' } -- 우선 순위
        },
        completion = { completopt = 'menu, menuone, noinsert' },
      })

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
          { name = 'cmdline_history' },
        }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
          { name = 'cmdline_history' },
          { name = 'cmdline' },
        })
      })

      -- for _, cmd_type in ipairs({ ':', '/', '?', '@' }) do
      --   cmp.setup.cmdline(cmd_type, {
      --     sources = {
      --       { name = 'cmdline_history' },
      --     },
      --   })
      -- end
    end,
  },
  {
    'dcampos/nvim-snippy',
    lazy = true,
    dependencies = {
      'dcampos/cmp-snippy',
    }
  },
  {
    'dcampos/cmp-snippy',
    lazy = true,
  },
  {
    'williamboman/mason.nvim',
    lazy = false, -- mason자체가 lazy로딩을 하므로, 다른 방법을 쓰지 말라 한다.
    config = function()
      return Config_mason()
    end,
    dependencies = { 'j-hui/fidget.nvim' }
  },
  {
    'williamboman/mason-lspconfig.nvim',
    lazy = true,
    dependencies = { 'williamboman/mason.nvim' }
  },
  {
    'ahmedkhalf/lsp-rooter.nvim',
    lazy = false, -- LSP가 불릴 때 이벤트가 아직 뭔지 모르겠다.
    config = function()
      require "lsp-rooter".setup {}
    end,
  },
  --[[ { 'RRethy/vim-illuminate' }, ]]
  { 'mattn/webapi-vim' },
  {
    'sindrets/diffview.nvim',
    lazy = true,
    cmd = "DiffviewOpen",
    config = function()
      require("diffview").setup {}
    end,
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  --  { 'petertriho/nvim-scrollbar' },
  --  오른쪽 스크롤러가 내용을 가리는 경우가 있다.
  -- { 'ahmedkhalf/project.nvim',
  --   config = function()
  --     require "project_nvim".setup {}
  --   end,
  -- },
  { 'dstein64/vim-startuptime' },
  {
    'wthollingsworth/pomodoro.nvim',
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
  {
    "hkupty/iron.nvim",
    lazy = true,
    cmd = "IronRepl",
    config = function()
      require "iron.core".setup {
        config = {
          scratch_repl = true,
          repl_definition = {
            -- custom repl that loads the current file
            -- haskell = {
            --   command = function(meta)
            --     local filename = vim.api.nvim_buf_get_name(meta.current_bufnr)
            --     return { 'cabal', 'v2-repl', filename }
            --   end
            -- }
          }
        },
        repl_open_cmd = require "iron.view".bottom(40),
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
      { '<space>is', '<cmd>IronRepl<cr>',    desc = "Iron Repl" },
      { '<space>ir', '<cmd>IronRestart<cr>', desc = "Iron Restart" },
      { '<space>if', '<cmd>IronFocus<cr>',   desc = "Iron Focus" },
      { '<space>ih', '<cmd>IronHide<cr>',    desc = "Iron Hide" },
    }
  },
  -- { 'echasnovski/mini.starter',
  --   version = '*',
  --   config = function()
  --     require "mini.starter".setup {}
  --   end,
  -- },
  {
    'folke/trouble.nvim',
    lazy = true,
    cmd = "Trouble",
    config = function()
      require "trouble".setup()
    end,
  },
  {
    'RRethy/nvim-treesitter-textsubjects',
    config = function()
      require('nvim-treesitter.configs').setup {
        textsubjects = {
          enable = true,
          prev_selection = ',',              -- (Optional) keymap to select the previous selection
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
    cmd = "ColorizerToggle",
    config = function()
      require 'colorizer'.setup()
    end,
  },
  {
    'kevinhwang91/nvim-hlslens',
    config = function()
      require('hlslens').setup({
        nearest_only = true,
        nearest_float_when = 'auto',
      })
    end,
  },
  {
    'windwp/nvim-autopairs',
    lazy = false,
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require('nvim-autopairs.rule')

      npairs.setup({
        check_ts = true,
        ts_config = {
          lua = { 'string' }, -- it will not add a pair on that treesitter node
          javascript = { 'template_string' },
          java = false,       -- don't check treesitter on java
        },
        fast_wrap = {
          map = '<C-a>',
          chars = { '{', '[', '(', '"', "'", '`' },
        }
      })
      local ts_conds = require('nvim-autopairs.ts-conds')

      -- press % => %% only while inside a comment or string
      npairs.add_rules({
        Rule("%", "%", "lua")
            :with_pair(ts_conds.is_ts_node({ 'string', 'comment' })),
        Rule("$", "$", "lua")
            :with_pair(ts_conds.is_not_ts_node({ 'function' }))
      })

      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end,

  },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require("nvim-ts-autotag").setup {}
    end,
  },
  -- { "hrsh7th/nvim-pasta",
  --   keys = {
  --     { 'p', [[:lua require"pasta.mappings".p()<CR>]], noremap = true },
  --     { 'P', [[:lua require"pasta.mappings".P()<CR>]], noremap = true },
  --   },
  --   config = function()
  --     require("nvim-pasta").setup {}
  --   end,
  -- },
  {
    'mfussenegger/nvim-dap',
    lazy = true,
    keys = {
      { '<F8>',  [[:lua require"dapui".toggle()<CR>]],          noremap = true },
      { '<F9>',  [[:lua require"dap".toggle_breakpoint()<CR>]], noremap = true },
      { '<F5>',  [[:lua require"dap".continue()<CR>]],          noremap = true },
      { '<F10>', [[:lua require"dap".step_over()<CR>]],         noremap = true },
      { '<F11>', [[:lua require"dap".step_into()<CR>]],         noremap = true },
      { '<F12>', [[:lua require"dap.ui.widgets".hover()<CR>]],  noremap = true },
      { '<F4>',  [[:lua require"dap".repl.open()<CR>]],         noremap = true }
    },
    config = function()
      local workspaceFolder = vim.fn.getcwd()
      local dap = require "dap"

      dap.adapters.haskell = {
        type = 'executable',
        command = 'haskell-debug-adapter',
        args = { '--hackage-version=0.0.38.0' },
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
          ghciCmd =
          "stack ghci --with-ghc=haskell-dap --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show",
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
    keys = { { '<F6>', ':lua require"osv".launch({port = 8086})<CR>', 'Nlua Debugger' }, },
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
    end
  },
  {
    'rcarriga/nvim-dap-ui',
    lazy = true,
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      require("dapui").setup()
    end,
  },
  {
    'TimUntersberger/neogit',
    config = function()
      require "neogit".setup {}
    end,
    lazy = true,
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = "Neogit"
  },
  {
    'nanotee/zoxide.vim',
    lazy = false,
    dependencies = { 'junegunn/fzf' },
  },
  {
    "atusy/tsnode-marker.nvim",
    lazy = false,
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("tsnode-marker-markdown", {}),
        pattern = { "markdown", "md" },
        callback = function(ctx)
          require("tsnode-marker").set_automark(ctx.buf, {
            target = { "code_fence_content" }, -- list of target node types
            hl_group = "CursorLine",           -- highlight group
          })
        end,
      })
    end,
  },
  {
    "kylechui/nvim-surround",
    lazy = false,
    config = function()
      local right = function()
        local nowCol = vim.api.nvim_eval([[virtcol('.')]])
        local lastCol = vim.api.nvim_eval([[virtcol('$')]]) - 1
        if nowCol == lastCol then
          vim.cmd("startinsert!")
        else
          vim.cmd("norm! a")
        end
      end
      require("nvim-surround").setup {
        keymaps = { ['visual'] = "s" },
      }
      -- 디폴트 `ys`를 선행키로 잡으면 약간의 딜레이가 생긴다.
      vim.keymap.set('n', 's', function() vim.cmd.normal("viws`f`l") end, { desc = 'Surround backtick' })
      --vim.keymap.set('n', 's', function() vim.cmd.normal("ysiw`f`l") end, { desc = 'Surround backtick' })
      vim.keymap.set('i', '<C-s>', function()
        vim.cmd.normal("hviws`f`l"); right()
      end, { silent = false })
      --vim.keymap.set('i', '<C-s>', function() vim.cmd.normal("ysiw`f`"); vim.cmd("startinsert!") end, { silent = false })
      vim.keymap.set('v', '<C-s>', function()
        vim.cmd.normal("s`f`"); right()
      end, { silent = false })
    end,
    -- vi{ v모드 {괄호 안쪽 선택
  },
  {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {}
    end
  },
  {
    "kiyoon/haskell-scope-highlighting.nvim",
    ft = "haskell",
    config = function()
      require("haskell-scope-highlighting").setup {}
      vim.cmd("syntax off") -- neovim 디폴트 문법 강조 끄기
      --      vim.cmd("TSDisable highlight") -- 트리시터 문법 강조 끄기
      vim.cmd("hi link @function.haskell purple")
      vim.cmd("hi link HaskellVariableDeclaredWithinFile BlueSign")
      vim.cmd("hi! link HaskellVariableNotDeclaredWithinFile Grey")
      vim.cmd("hi HaskellVariableDeclaredWithinScope guifg=lightblue")
      vim.cmd("hi HaskellVariableDeclarationWithinScope guifg=lightblue")
      vim.cmd("hi HaskellCurrentScope guibg=#343f44")
      local i = 1
      repeat
        -- orange = #dc9271
        local color = string.format("%d guifg=#%02x%02x%02x", i,
          220 - (i * 10) % 220,
          92 - (i * 20) % 92,
          72 + (i * 20) % 184
        )
        vim.cmd("hi HaskellVariableDeclaredWithinParent" .. color)
        vim.cmd("hi HaskellParentScope" .. i .. " guibg=#2d353b")
        i = i + 1
      until (i > 10)
    end,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  -- find & replace를 여러 파일에 먹이고 싶을 때
  -- quickfix를 복사해서 일반 버퍼에서 열고,
  -- 수정하고 저장하면 해당하는 파일들을 업데이트 한다.
  -- {
  --   'Olical/vim-enmasse',
  --   lazy = true,
  --   cmd = "EnMasse",
  -- },
  {
    'willothy/flatten.nvim',
    config = true,
    lazy = false,
    priority = 1001,
    opts = {
      callbacks = {
        pre_open = function()
          require("toggleterm").toggle(0)
        end,
        post_open = function(bufnr, winnr, ft, is_blocking)
          require("toggleterm").toggle(0)
        end
      }
    }
  },
  {
    'JellyApple102/flote.nvim',
    config = true,
    lazy = true,
    cmd = "Flote",
  },
  {
    "rest-nvim/rest.nvim",
    lazy = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        '<leader>rn',
        function()
          vim.cmd [[execute "normal \<Plug>RestNvim"]]
        end,
        mode = { 'n' },
        silent = false,
        desc = "RestNvim"
      },
      {
        '<leader>rp',
        function()
          vim.cmd [[execute "normal \<Plug>RestNvimPreview"]]
        end,
        mode = { 'n' },
        silent = false,
        desc = "RestNvimPreview"
      },
      {
        '<leader>rl',
        function()
          vim.cmd [[execute "normal \<Plug>RestNvimLast"]]
        end,
        mode = { 'n' },
        silent = false,
        desc = "RestNvimLast"
      },

    },

    config = function()
      require("rest-nvim").setup({
        -- Open request results in a horizontal split
        result_split_horizontal = false,
        -- Keep the http file buffer above|left when split horizontal|vertical
        result_split_in_place = false,
        -- Skip SSL verification, useful for unknown certificates
        skip_ssl_verification = false,
        -- Encode URL before making request
        encode_url = true,
        -- Highlight request on run
        highlight = {
          enabled = true,
          timeout = 150,
        },
        result = {
          -- toggle showing URL, HTTP info, headers at top the of result window
          show_url = true,
          -- show the generated curl command in case you want to launch
          -- the same request via the terminal (can be verbose)
          show_curl_command = false,
          show_http_info = true,
          show_headers = true,
          -- executables or functions for formatting response body [optional]
          -- set them to false if you want to disable them
          formatters = {
            json = "jq",
            html = function(body)
              return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
            end
          },
        },
        -- Jump to request line on run
        jump_to_request = false,
        env_file = '.env',
        custom_dynamic_variables = {},
        yank_dry_run = true,
      })
    end
  },
  -- { 'stevearc/stickybuf.nvim',
  --   opts = {},
  --   config = true,
  -- },
  {
    'tzachar/highlight-undo.nvim',
    config = function()
      require('highlight-undo').setup({
        hlgroup = 'HighlightUndo',
        duration = 300,
        keymaps = {
          { 'n', 'u',     'undo', {} },
          { 'n', '<C-r>', 'redo', {} },
        }
      })
    end
  },
  {
    "kiyoon/treesitter-indent-object.nvim",
    keys = {
      {
        "ai",
        "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer()<CR>",
        mode = { "x", "o" },
        desc = "Select context-aware indent (outer)",
      },
      {
        "aI",
        "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer(true)<CR>",
        mode = { "x", "o" },
        desc = "Select context-aware indent (outer, line-wise)",
      },
      {
        "ii",
        "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner()<CR>",
        mode = { "x", "o" },
        desc = "Select context-aware indent (inner, partial range)",
      },
      {
        "iI",
        "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner(true)<CR>",
        mode = { "x", "o" },
        desc = "Select context-aware indent (inner, entire range)",
      },
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  {
    'stevearc/oil.nvim',
    keys = {
      {
        '<leader>\\',
        mode = { "n", "v" },
        function()
          if vim.bo[0].filetype == "oil"
          then
            require("oil.actions").close.callback()
          else
            vim.cmd('Oil')
          end
        end,
        silent = true,
        desc = "Oil"
      },
    },
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({})
    end
  },
  {
    'vidocqh/auto-indent.nvim',
    opts = {},
    config = true,
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "BufEnter",
    -- or leave it empty to use the default settings
    keys = {
      -- suggested keymap
      { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste clipboard image" },
    },
  },
  -- {
  --   "karb94/neoscroll.nvim",
  --   config = function()
  --     require('neoscroll').setup {}
  --   end
  -- },
  -- {
  --   'rasulomaroff/reactive.nvim',
  --   config = function()
  --     require('reactive').setup {
  --       builtin = {
  --         cursorline = true,
  --         cursor = true,
  --         modemsg = true
  --       }
  --     }
  --   end
  -- },
  -- {
  --   "soulis-1256/hoverhints.nvim",
  --   config = true
  -- },
  -- {
  --   'edluffy/hologram.nvim',
  --   lazy = false,
  --   config = function()
  --     require('hologram').setup {
  --       auto_display = true -- WIP automatic markdown image display, may be prone to breaking
  --     }
  --   end,
  --   rocks = { "magick" },
  -- },

  -- {
  --   'jose-elias-alvarez/null-ls.nvim',
  --   config = true,
  --   lazy = true,
  -- },
  --
  {
    --'lionhairdino/saekpen.nvim',
    dir = vim.fn.stdpath('config') .. '/saekpen',
    config = true,
    cmd = { 'SaekpenMode' }
  },
  {
    "mpas/marp-nvim",
    config = true,
    cmd = { 'MarpToggle' }
  },
  {
    {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      opts = {
        indent = { char = "▏" },
      }
    }
  },
  {
    "ojroques/nvim-bufdel",
    config = true,
    cmd = { 'BufDel' }
  },
}

local config_group = vim.api.nvim_create_augroup('MyConfigGroup', {}) -- A global group for all your config autocommands

vim.api.nvim_create_autocmd(
  { "BufReadPost" },
  {
    group = config_group,
    pattern = { "*" },
    callback = function()
      local current_buf = vim.api.nvim_get_current_buf()
      --local buftype = vim.api.nvim_buf_get_option(current_buf, 'buftype')
      --print ("buftype: " ..buftype)
      local lines = vim.api.nvim_buf_get_lines(current_buf, -5, -1, false)
      for _, line in ipairs(lines) do
        local matched = string.find(line, '/Saekpen', 1, false)
        if matched ~= nil then
          vim.api.nvim_command('SaekpenMode')
          vim.api.nvim_command('SaekpenInput')
          vim.api.nvim_command('SaekpenMode')
          break
        end
      end
    end
  }
)


--require("scrollbar").setup{} -- 오른쪽 끝의 텍스트를 가리는 경우가 있다.
-- LSP의 Capabilities란?
-- LSP서버는 클라이언트 능력Capabilities에 따라 다른 자동완성completion 결과를 제공한다.
-- Neovim의 디폴트 omnifunc는 기본으로 자동완성 제안을 보여준다.
-- nvim-cmp는 더 많은 타입의 자동완성 제안을 지원한다.
--
require("lazy").setup(plugins)

-- 어느 플러그인에선가 바꾸고 있는 것 같다. 첫부분에 써주면 작동 안하는데,
-- 마지막에 써주면 작동한다.
set.guicursor =
'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175'

-- 0.9로 올리고 작동하지 않는다.
-- 입력 모드일 때만 row를 표시하는 선line을 가린다.
-- vim.api.nvim_create_autocmd(
--   { "InsertEnter" },
--   { pattern = "*",
--     command = "set nocul" }
-- )
-- vim.api.nvim_create_autocmd(
--   { "InsertLeave" },
--   { pattern = "*",
--     command = "set cul" }
-- )

-- FindClosing = function()
--
--   local ts_utils = require "nvim-treesitter.ts_utils"
--   local starting_node = ts_utils.get_node_at_cursor()
--   if starting_node == nil then
--     return
--   end
--
--   local ft = vim.bo.filetype
--   local br = [[ "(" ")" "[" "]" "{" "}" ]]
--   local query = vim.treesitter.parse_query(ft, br)
--
--   local sr, sc, er, ec = vim.treesitter.get_node_range(starting_node)
--   vim.api.nvim_win_set_cursor(0, { er, ec + 1 })
--
-- end
vim.keymap.set('n', '<F7>', ':lua Select()<CR>', { desc = 'Test' })
vim.keymap.set('i', '<C-x>',
  function()
    vim.cmd.normal("xli") -- 입력 모드에서 delete
  end,
  { desc = 'Delete' })

vim.api.nvim_create_autocmd({ 'BufRead', 'BufReadPost' }, {
  callback = function()
    local row, column = unpack(vim.api.nvim_buf_get_mark(0, '"'))
    local buf_line_count = vim.api.nvim_buf_line_count(0)

    if row >= 1 and row <= buf_line_count then
      vim.api.nvim_win_set_cursor(0, { row, column })
    end
  end,
})

-- Important: This will close anything non-buffer,
-- including notifications, neotree, aerial...
-- So if you need to keep them open, use 'VimLeavePre'.
-- Auto save session
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  callback = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      -- Don't save while there's any 'nofile' buffer open.
      if vim.api.nvim_get_option_value("buftype", { buf = buf }) == 'nofile' then
        return
      end
    end
    require('session_manager').save_current_session()
  end
})
