-- 2022.10.31 lionhairdino at gmail.com
-- 몇 가지만 지정해도 되는데, 테스트로 가능한 모든 걸 긁어온다. 용량은 무시할만 하다.
-- Haskell Language Server + LSP Native + Coq
--
-- ※ Coq은 증명 언어를 얘기하는 게 아니라, 자동 완성 플러그인 이름이다.
-- Native가 아닌 Coc으로 설정할 때는 자동 완성이 따로 필요없지만,
-- Native로 할 때는 필요하다.
--
--
-- :Hoogle 명령어로 검색

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
--set.nocompatible = true
set.splitbelow = true
set.splitright = true
set.clipboard = 'unnamedplus'
set.undodir = vim.fn.stdpath('cache') .. '/undodir/'
set.undofile = true

set.printencoding = 'utf8'
set.printmbcharset = 'ISO10646'
set.printmbfont = 'r:D2CodingLigature,c:yes,a:yes'
set.printfont = 'D2CodingLigature:h10'
--set.printdevice = 'FUJI_XEROX_DocuPrint_CP225_228_w_'
set.printdevice = 'HP-LaserJet-1200'
--set.timeoutlen = 300

local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')
Plug 'junegunn/fzf'
-- 이 자체가 lsp클라이언트가 아니라, 클라이언트는
-- 빌트인 되어 있고, 이 건 설정을 도와준다.
Plug 'neovim/nvim-lspconfig'
-- 특정 기호등을 기준으로 정렬할 때 쓴다.
-- :Tabularize /= (이렇게 하면 =을 기준으로 정렬된다.)
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
Plug('EdenEast/nightfox.nvim', { branch = 'main' })
Plug 'marko-cerovac/material.nvim'
Plug('purescript-contrib/purescript-vim', { branch = 'main' })
Plug 'vmchale/dhall-vim'
Plug('iamcco/markdown-preview.nvim', { ['do'] = vim.fn['cd app && yarn install'] })
Plug 'MattesGroeger/vim-bookmarks'
Plug 'kassio/neoterm'
--Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-tree/nvim-web-devicons'
Plug('akinsho/bufferline.nvim', { tag = 'v3.*' })
Plug 'nvim-tree/nvim-tree.lua'
--Plug 'kyazdani42/nvim-tree.lua'
Plug 'itchyny/lightline.vim'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'tpope/vim-fugitive' -- Git
Plug('idanarye/vim-merginal', { branch = 'develop' })
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'numkil/ag.nvim'
Plug('duane9/nvim-rg', { branch = 'main' })
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'monkoose/fzf-hoogle.vim'
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
--Plug ('rmagatti/auto-session', {branch = 'main'})
--Plug ('rmagatti/session-lens', {branch = 'main'})
-- 인자 없이 nvim을 시작하면 현재 cwd(Current Working Directory)를 위한 세션이 있으면 불러온다.
-- 파일 지정 없이 nvim . 으로 열면 auto-session은 개입하지 않는다.
Plug 'nvim-lualine/lualine.nvim'
Plug('kdheepak/lazygit.nvim', { branch = 'main' })
-- Plug ('ms-jpq/coq_nvim', {branch = 'coq'})
-- Plug ('ms-jpq/coq.artifacts', {branch = 'artifacts'})
-- Plug ('ms-jpq/coq.thirdparty', {branch = '3p'})
--coq 설치할 때 파이썬 virtualenv(venv)가 apt install python3-env로 설치가 안됐다
-- aptitude instll python3-env로 하면 된다.
--Plug ('ms-jpq/chadtree', {branch = 'chad', ['do'] = 'python3 -m chadtree deps'})
Plug 'simrat39/symbols-outline.nvim'
Plug 'numToStr/Comment.nvim'
Plug 'nvim-orgmode/orgmode'
Plug 'linty-org/key-menu.nvim' --팝업 메뉴
--Plug 'glacambre/firenvim' 파이어폭스 웹 입력창에 nvim 로드
Plug 'kevinhwang91/nvim-bqf'
Plug 'caenrique/nvim-maximize-window-toggle'
Plug('echasnovski/mini.nvim', { branch = 'stable' })
Plug('echasnovski/mini.indentscope', { branch = 'stable' })
--Plug ('echasnovski/mini.pairs', { branch = 'stable' })
--Plug ('echasnovski/mini.sessions', { branch = 'stable' })
Plug 'jedrzejboczar/possession.nvim'
Plug('echasnovski/mini.surround', { branch = 'stable' })
Plug('echasnovski/mini.completion', { branch = 'stable' })
Plug('echasnovski/mini.starter', { branch = 'stable' })
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-calc'
Plug 'hrsh7th/nvim-cmp'
Plug 'dcampos/nvim-snippy'
Plug 'dcampos/cmp-snippy'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
--Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'ahmedkhalf/lsp-rooter.nvim'
Plug 'RRethy/vim-illuminate'
Plug 'mattn/webapi-vim'
Plug 'TimUntersberger/neogit'
Plug 'sindrets/diffview.nvim'
Plug 'petertriho/nvim-scrollbar'
Plug 'ahmedkhalf/project.nvim'
Plug 'tom-anders/telescope-vim-bookmarks.nvim'

vim.call('plug#end')

vim.g['vim_markdown_folding_disabled'] = 1
-- vim.g['vim_markdown_toc_autofit'] = 1
-- vim.g['mkdp_auto_start'] = 1
-- vim.g['mkdp_auto_close'] = 1
-- vim.g['neoterm_autoscroll'] = 1
vim.g['neoterm_size'] = 10
vim.g['neoterm_autoinsert'] = 1
vim.g['fzf_preview_window'] = { 'hidden,right,50%,<70(up,40%)', 'ctrl-/' }
-- [Buffers] Jump to the existing window if possible
vim.g['fzf_buffers_jump'] = 1
-- [[B]Commits] Customize the options used by 'git log':
vim.g['fzf_commits_log_options'] = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
-- [Tags] Command to generate tags file
vim.g['fzf_tags_command'] = 'ctags -R'
-- [Commands] --expect expression for directly executing the command
vim.g['fzf_commands_expect'] = 'alt-enter,ctrl-x'
vim.g['mkdp_theme'] = 'light'

--vim.cmd.colorscheme('nightfox')
vim.cmd.colorscheme('material')
vim.g.material_style = "oceanic"
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

-- local pandocGrp = vim.api.nvim_create_augroup("pandoc_syntax", { clear = true })
-- vim.api.nvim_create_autocmd(
--   { "BufNewFile","BufFilePre","BufRead" },
--   { pattern = "*.md", command = "set filetype=markdown.pandoc", group = pandocGrp }
-- )
--


-- local chadtree_settings = {
--   ['options.close_on_open'] = false, -- 파일을 열고나면 chadtree를 닫는다.
--   ['xdg'] = false,
--   ['options.show_hidden'] = true,
-- }
-- vim.api.nvim_set_var("chadtree_settings", chadtree_settings)
--
-- nvim tree는 세션 저장한 후 불러오면 살아 돌아오는데,
-- chad tree는 안된다.
-- 종료할 때, CHADTree 버퍼는 모두 닫는다.
-- todo 세션관련 해결책이 나오면 바꾸자.
-- vim.api.nvim_create_autocmd(
--   {"VimLeavePre"},
--   { command = ":windo :if &ft=='CHADTree' | :lua CHAD.Save_session(); vim.cmd(':bd | :endif')" }
-- )
--
-- 점프키와 충돌 vim.keymap.set({'n'}, '<Tab>', 'za', {silent = true})
vim.keymap.set({ 'n' }, 'k', 'gk', { silent = true })
vim.keymap.set({ 'n' }, 'j', 'gj', { silent = true })
-- Shift-BS는 작동하지 않고 있다. 이유는 아직 모른다.
vim.keymap.set({ 'i' }, '<Shift-BS>', '<kDel>', { silent = true })
vim.keymap.set({ 'i', 'n', 'v' }, '<leader>\\', ':Tnew<CR>', { silent = true })
--vim.keymap.set({'n'}, '<Tab>', ':tabnext<CR>', {silent = true})
--vim.keymap.set({'n'}, '<S-Tab>', ':tabprevious<CR>', {silent = true})
--vim.keymap.set({'n','v','i'}, '<C-n>', ':NERDTreeToggle<CR>')
vim.keymap.set('n', '<space>f',
  function() return require('telescope.builtin').find_files() end, { desc = 'Find Files' })
vim.keymap.set('n', '<space>r',
  function() return require('telescope.builtin').find_files() end, { desc = 'Recent Files' })
vim.keymap.set('n', '<space>g',
  function() return require('telescope.builtin').live_grep { search_dirs = { '.' } } end, { desc = 'Live Grep' })
vim.keymap.set('n', '<space>b',
  function() return require('telescope.builtin').buffers() end, { desc = 'Buffers' })
vim.keymap.set('n', '<space>s',
  function() return require('telescope').extensions.possession.list() end, { desc = 'Session' })
vim.keymap.set('n', '<space>p',
  function() return require('telescope').extensions.projects.projects() end, { desc = 'Project' })
vim.keymap.set('n', '<space>m',
  function() return require('telescope').extensions.vim_bookmarks.all() end, { desc = 'Bookmarks' })




vim.keymap.set('n', '<F9>', ':LazyGit<CR>', { desc = 'Git' })
vim.keymap.set({ 'n', 'v', 'i' }, '<leader>m', ':ToggleOnly<CR>', { desc = 'Send to new tab' })

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
-- 윈도우 크기 조절
vim.keymap.set('n', '=', ':resize +5<CR>', { desc = 'incresing height', silent = true })
vim.keymap.set('n', '-', ':resize -5<CR>', { desc = 'incresing height', silent = true })
vim.keymap.set('n', '+', ':vertical resize +5<CR>', { desc = 'incresing width', silent = true })
vim.keymap.set('n', '_', ':vertical resize -5<CR>', { desc = 'incresing width', silent = true })

local function on_attach_keysetup(client, bufnr)
  local function buf_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_keymap('n', 'K', ':lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
  buf_keymap('n', '<C-]>', ':lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
  buf_keymap('n', 'gA', ':lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
  buf_keymap('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
  buf_keymap('n', 'gD', ':lua vim.lsp.buf.type_definition()<CR>', { noremap = true, silent = true })
  buf_keymap('n', '<leader>fs', ':lua vim.lsp.buf.workspace_symbol()<CR>', { noremap = true, silent = true })
  buf_keymap('n', '<C-e>', ':lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
  buf_keymap('n', 'g[', ':lua vim.lsp.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
  buf_keymap('n', 'g]', ':lua vim.lsp.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
  buf_keymap('n', 'gl', ':lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })
  buf_keymap('n', 'gr', ':lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
  buf_keymap('n', 'gR', ':lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
  buf_keymap('n', 'gs', ':lua vim.lsp.codelens.refresh()<CR>', { noremap = true, silent = true })
  buf_keymap('n', 'ge', ':lua vim.lsp.codelens.run()<CR>', { noremap = true, silent = true })
  buf_keymap('', '<leader>F', ':lua vim.lsp.buf.format{ async = true }<CR>', { noremap = true, silent = true })
end

local function on_attach(client, bufnr)
  on_attach_keysetup(client, bufnr);
  -- 매핑이 제대로 동작하는지 nvim 안에서 :map gd 등을 입력해서 알 수 있다.

  vim.opt_local.signcolumn = 'yes'
  vim.api.nvim_create_autocmd(
    { "BufEnter", "CursorHold", "InsertLeave" },
    { pattern = { "*.hs", "*.hls" },
      callback = function()
        vim.lsp.codelens.refresh()
      end
    }
  )
  set.tagfunc = 'lua vim.lsp.tagfunc()'
end

-- vim.g.coq_settings = {
--   auto_start = true,
--   ["display.pum.fast_close"] = false,
--   ["keymap.pre_select"] = false,
--   ["keymap.recommended"] = false,
--   ["keymap.jump_to_mark"] = "<c-q>", -- 다음 플레이스 홀더 위치 이동 디폴트가 <c-h>를 쓰는데, 나는 <c-h>를 <bs>로 쓴다.
--   ["keymap.manual_complete_insertion_only"] = true,
-- }
--
-- -- Keybindings for Coq
-- function _G.Coq_esc()
--   -- 제안창이 떠 있을 때 제안창을 닫고 입력 모드를 빠져 나간다.
--   -- 제안창 취소는 C-e가 손에 익어야 한다.
--   return vim.fn.pumvisible() == 1 and [[<C-e><Esc>]] or [[<Esc>]]
-- end
--
-- function _G.Coq_enter()
--   -- 줄 바꿈을 위해 Enter를 쳐야 하는 상황에 제안이 떠있으면
--   -- 제안을 취소하고 Enter를 치는 불편함이 있다.
--   -- 제안창이 떠있을 때
--   -- 첫 번째가 아닌 걸 선택했을 때는 선태하는 키로, 그 외는 취소 동작을 먼저하고 줄바꿈을 한다.
--    return vim.fn.pumvisible() == 0 and
--      (vim.fn.complete_info().selected ~= 0 and [[<C-y>]] or [[<C-e><CR>]])
--        or [[<CR>]]
-- end
--
-- function _G.Coq_Cc()
--   return vim.fn.pumvisible() == 1 and [[<C-e><C-c>]] or [[<C-c>]]
-- end
--
-- function _G.Coq_completion()
--   -- tab을 select하는 동작으로 바꿨다.
--   print "tab!!!"
--   p
--   return vim.fn.pumvisible() == 1 and
--     (vim.fn.complete_info().selected == -1 and [[<C-e><tab>]] or [[<C-y>]])
--       or [[<tab>]]
-- end
--
-- vim.keymap.set('i' , "<Esc>"   , 'v:lua.Coq_esc()'        , {silent=true , expr=true})
-- vim.keymap.set('i' , "<C-c>"   , 'v:lua.Coq_Cc()'         , {silent=true , expr=true})
-- vim.keymap.set('i' , "<Tab>"   , 'v:lua.Coq_completion()' , {silent=true , expr=true})
-- vim.keymap.set('i' , "<Enter>" , 'v:lua.Coq_enter()'      , {silent=true , expr=true}) -- Org모드에서 원하는대로 동작하지 않는다. 일단 꺼두자. 제안목록 중에 선택하는 키는 항상 탭을 쓰게 연습하면 된다. 아마도 Coc 단축키와 충돌하는 것 같다.
--
require('lualine').setup {
  options = { theme = 'ayu_mirage' },
  sections = { lualine_y = { 'progress', 'filesize' } }
  --sections = {lualine_c = {require('auto-session-library').current_session_name}}
}
--vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

-- require("auto-session").setup {
--   log_level = "error",
--   auto_session_enable_last_session=true,
--   cwd_change_handling = {
--     --restore_upcoming_session = true, -- already the default, no need to specify like this, only here as an example
--     --pre_cwd_changed_hook = nil, -- already the default, no need to specify like this, only here as an example
--     post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
--       require("lualine").refresh() -- refresh lualine so the new session name is displayed in the status bar
--     end,
--   },
-- }

-- require('session-lens').setup {
--     path_display={'shorten'},
--     theme_conf = { border = false },
--     previewer = true
-- }
require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "haskell", "lua", "javascript", "typescript", "vim", "rust", "python", "graphql", "html", "css",
    "json" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
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
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@comment.outer",
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
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
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
  autofold_depth = nil,
  auto_unfold_hover = true,
  fold_markers = { '', '' },
  wrap = false,
  keymaps = { -- These keymaps can be a string or a table for multiple keys
    close = { "<Esc>", "q" },
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

require("symbols-outline").setup { opt = outline_opts }

------ Nvim-tree
-- 기본 탐색기 끄기
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

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

require('Comment').setup()
require('orgmode').setup_ts_grammar()
vim.opt.conceallevel = 0
vim.opt.concealcursor = 'nc'
require('orgmode').setup({
  org_agenda_files = { '~/notes/*', '~/notes/**/*' },
  org_default_notes_file = '~/notes/refile.org',
})

--- 팝업 keymap
-- 보통 아는 명령어면 연달아서 입력한다. 600밀리초 지나도 다음 키가 안들어 오면 메뉴를 띄운다.
--vim.o.timeoutlen = 1200
require 'key-menu'.set('n', '<leader>')
require 'key-menu'.set('n', '<Space>')
require 'key-menu'.set('n', 'g')
require 'key-menu'.set('n', 'c')
require 'key-menu'.set('n', 's')
vim.keymap.set({ 'n', 'i', 'v' }, '<F1>', function() require 'key-menu'.open_window('') end, { desc = 'Key Binding' })
vim.keymap.set({ 'n', 'i', 'v' }, '<F2>', ':cd %:h<CR>', { desc = 'Change Current Directory' })
-- 아래처럼 메뉴를 지정해도 된다.
--vim.keymap.set('n', '<Space>o',
--  function() require 'key-menu'.open_window('<leader>o') end, {desc='Orgmode'})
--[[ local erase_all_lines = function()
  vim.api.nvim_buf_set_lines(0, 0, -1, false, {})
end
vim.keymap.set('n', '<Space>k', erase_all_lines, {desc='Erase all'})

-- You can put mappings several keys deep, in a mapping group. For some kinds of
-- mappings, even if you don't include a description, key-menu will try to
-- render them nicely, for example by not showing the <Cmd> and <CR>.
require 'key-menu'.setvim.keymap.set('n', '<Space><F9>', ':LazyGit<CR>', {desc='LazyGit'})
vim.keymap.set('n', '<Space>g',
  function() require 'key-menu'.open_window('<Space>g') end,
  {desc='Git'})
vim.keymap.set('n', '<leader>',
  function() require 'key-menu'.open_window('<leader>g') end,
  {desc='Leader'})
]]

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
      -- Delay (in ms) between event and start of drawing scope indicator
      delay = 100,
      -- Animation rule for scope's first drawing. A function which, given
      -- next and total step numbers, returns wait time (in ms). See
      -- |MiniIndentscope.gen_animation()| for builtin options. To disable
      -- animation, use `require('mini.indentscope').gen_animation('none')`.
      animation = function(s, n)
        return 20
      end,
    },
    -- Module mappings. Use `''` (empty string) to disable one.
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
      try_as_border = false,
    },
    -- Which character to use for drawing scope indicator
    symbol = '╎',
  }
)

--require('mini.pairs').setup()
-- require('mini.sessions').setup({
--   autoread = false,
--   autowrite = true,
--   verbose = { read = true, write = true, delete = true },
--   directory = vim.fn.stdpath('cache')..'/sessions/',
--   file = 'Session.vim'
--
-- })
require('mini.surround').setup()
--require('mini.completion').setup()

set.completeopt = { 'menu', 'menuone', 'noselect' }
-- Set up nvim-cmp.
local cmp = require 'cmp'
local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('snippy').expand_snippet(args.body) -- For `snippy` users.
    end,
  },
  window = {
    --completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  -- 아래 키가 어디에서 쓰이는지 모르겠다.
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items. true로 하면 첫 번째가 선택되어 있는 걸로 간주한다.
    --['<tab>'] = cmp.mapping.select_next_item(select_opts),
    --['<S-tab>'] = cmp.mapping.select_prev_item(select_opts),
  }),
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'calc' },
    { name = 'nvim_lsp' },
    { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  }),
  formatting = {
    fields = { 'menu', 'abbr', 'kind' }
  },
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
-- 찾기 모드에서도 자동 완성을 쓸 수 있다.
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
    { name = 'cmdline',
      option = {
        ignore_cmds = { 'Man', '!' }
      }
    }
  })
})

-- Set up lspconfig.
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--   capabilities = capabilities
-- }
--
-- local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
-- lsp_capabilities.textDocument.completion.completionItem.snippetSupport = true
-- lsp_capabilities.textDocument.completion.completionItem.resolveSupport = {
--   properties = {
--     'documentation',
--     'detail',
--     'additionalTextEdits',
--   }
-- }
--
require 'lspconfig'.hls.setup({
  --require'coq'.lsp_ensure_capabilities{
  --cmd = { "haskell-language-server-wrapper", "--lsp", "--debug" },
  cmd = { "haskell-language-server-wrapper", "--lsp" },
  filetypes = { "haskell", "lhaskell" },
  codeLens = { enabale = true },
  on_attach = on_attach,
  capabilities = lsp_capabilities,
  settings = {
    haskell = {
      hlintOn = true,
      formattingProvider = "stylish-haskell",
    }
  }
})

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
require("mason-lspconfig").setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup { on_attach = on_attach_keysetup }
  end,
}

require 'mini.starter'.setup()


--require'lspconfig'.sumneko_lua.setup {}
--require'lspconfig'.rust_analyzer.setup {}
require("lsp-rooter").setup {}
require("neogit").setup {}
require('possession').setup {}
require('project_nvim').setup {}

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

require('telescope').load_extension('possession')
require('telescope').load_extension('projects')
require('telescope').load_extension('file_browser')
require('telescope').load_extension('vim_bookmarks')
-- tree-sitter로 폴딩을 자동으로 만드는 것까진 좋은데, 디폴트로 모두 close 상태다.
-- 이를 처음 파일을 열면 열어두기 위해 아래 방법을 쓴다.
vim.api.nvim_create_autocmd(
  { "BufReadPost", "FileReadPost" },
  { pattern = "*",
    command = "normal zR"
  }
)

require("diffview").setup {}
--require("scrollbar").setup{} -- 오른쪽 끝의 텍스트를 가리는 경우가 있다.
require("bufferline").setup {}
