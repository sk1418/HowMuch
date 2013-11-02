" HowMuch : calculate visual selected math expressions
" Author  : Kai Yuan <kent.yuan@gmail.com>
" License: {{{
"Copyright (c) 2013 Kai Yuan
"Permission is hereby granted, free of charge, to any person obtaining a copy of
"this software and associated documentation files (the "Software"), to deal in
"the Software without restriction, including without limitation the rights to
"use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
"the Software, and to permit persons to whom the Software is furnished to do so,
"subject to the following conditions:
"
"The above copyright notice and this permission notice shall be included in all
"copies or substantial portions of the Software.
"
"THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
"IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
"FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
"COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
"IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
"CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}

"command to display version number:
"
let s:version ="1.0.0"
command! HowMuchVersion echo "HowMuch Version: " . s:version

"<Plug> mappings for auto engine
"{{{
vnoremap <silent><unique> <Plug>AutoCalcReplace            :call HowMuch#HowMuch(0,0,0,'auto')<cr>
vnoremap <silent><unique> <Plug>AutoCalcReplaceWithSum     :call HowMuch#HowMuch(0,0,1,'auto')<cr>
vnoremap <silent><unique> <Plug>AutoCalcAppend             :call HowMuch#HowMuch(1,0,0,'auto')<cr>
vnoremap <silent><unique> <Plug>AutoCalcAppendWithEq       :call HowMuch#HowMuch(1,1,0,'auto')<cr>
vnoremap <silent><unique> <Plug>AutoCalcAppendWithSum      :call HowMuch#HowMuch(1,0,1,'auto')<cr>
vnoremap <silent><unique> <Plug>AutoCalcAppendWithEqAndSum :call HowMuch#HowMuch(1,1,1,'auto')<cr>
"}}}

"<Plug> mappings for bc engine
"{{{
vnoremap <silent><unique> <Plug>BcCalcReplace              :call HowMuch#HowMuch(0,0,0,'bc')<cr>
vnoremap <silent><unique> <Plug>BcCalcReplaceWithSum       :call HowMuch#HowMuch(0,0,1,'bc')<cr>
vnoremap <silent><unique> <Plug>BcCalcAppend               :call HowMuch#HowMuch(1,0,0,'bc')<cr>
vnoremap <silent><unique> <Plug>BcCalcAppendWithEq         :call HowMuch#HowMuch(1,1,0,'bc')<cr>
vnoremap <silent><unique> <Plug>BcCalcAppendWithSum        :call HowMuch#HowMuch(1,0,1,'bc')<cr>
vnoremap <silent><unique> <Plug>BcCalcAppendWithEqAndSum   :call HowMuch#HowMuch(1,1,1,'bc')<cr>
"}}}

"<Plug> mappings for vim engine
"{{{
vnoremap <silent><unique> <Plug>VimCalcReplace             :call HowMuch#HowMuch(0,0,0,'vim')<cr>
vnoremap <silent><unique> <Plug>VimCalcReplaceWithSum      :call HowMuch#HowMuch(0,0,1,'vim')<cr>
vnoremap <silent><unique> <Plug>VimCalcAppend              :call HowMuch#HowMuch(1,0,0,'vim')<cr>
vnoremap <silent><unique> <Plug>VimCalcAppendWithEq        :call HowMuch#HowMuch(1,1,0,'vim')<cr>
vnoremap <silent><unique> <Plug>VimCalcAppendWithSum       :call HowMuch#HowMuch(1,0,1,'vim')<cr>
vnoremap <silent><unique> <Plug>VimCalcAppendWithEqAndSum  :call HowMuch#HowMuch(1,1,1,'vim')<cr>
"}}}

"<Plug> mappings for python engine
"{{{
vnoremap <silent><unique> <Plug>PyCalcReplace              :call HowMuch#HowMuch(0,0,0,'py')<cr>
vnoremap <silent><unique> <Plug>PyCalcReplaceWithSum       :call HowMuch#HowMuch(0,0,1,'py')<cr>
vnoremap <silent><unique> <Plug>PyCalcAppend               :call HowMuch#HowMuch(1,0,0,'py')<cr>
vnoremap <silent><unique> <Plug>PyCalcAppendWithEq         :call HowMuch#HowMuch(1,1,0,'py')<cr>
vnoremap <silent><unique> <Plug>PyCalcAppendWithSum        :call HowMuch#HowMuch(1,0,1,'py')<cr>
vnoremap <silent><unique> <Plug>PyCalcAppendWithEqAndSum   :call HowMuch#HowMuch(1,1,1,'py')<cr>
"}}}

"===========================================================

"default mappings for auto
"{{{
if !hasmapto('<Plug>AutoCalcReplace','v')
  vmap <leader>?r <Plug>AutoCalcReplace
endif
if !hasmapto('<Plug>AutoCalcReplaceWithSum','v')
  vmap <leader>?rs <Plug>AutoCalcReplaceWithSum
endif
if !hasmapto('<Plug>AutoCalcAppend','v')
  vmap <leader>? <Plug>AutoCalcAppend
endif

if !hasmapto('<Plug>AutoCalcAppendWithEq','v')
  vmap  <leader>?= <Plug>AutoCalcAppendWithEq
endif

if !hasmapto('<Plug>AutoCalcAppendWithSum','v')
  vmap  <leader>?s <Plug>AutoCalcAppendWithSum
endif

if !hasmapto('<Plug>AutoCalcAppendWithEqAndSum','v')
  vmap  <leader>?=s <Plug>AutoCalcAppendWithEqAndSum
endif"}}}

"default mappings for bc
"{{{
if !hasmapto('<Plug>BcCalcReplace','v')
  vmap  <leader>b?r <Plug>BcCalcReplace
endif

if !hasmapto('<Plug>BcCalcReplaceWithSum','v')
  vmap  <leader>b?rs <Plug>BcCalcReplaceWithSum
endif

if !hasmapto('<Plug>BcCalcAppend','v')
  vmap  <leader>b? <Plug>BcCalcAppend
endif

if !hasmapto('<Plug>BcCalcAppendWithEq','v')
  vmap  <leader>b?= <Plug>BcCalcAppendWithEq
endif

if !hasmapto('<Plug>BcCalcAppendWithSum','v')
  vmap  <leader>b?s <Plug>BcCalcAppendWithSum
endif

if !hasmapto('<Plug>BcCalcAppendWithEqAndSum','v')
  vmap  <leader>b?=s <Plug>BcCalcAppendWithEqAndSum
endif"}}}

"default mappings for vim
"{{{
if !hasmapto('<Plug>VimCalcReplace','v')
  vmap  <leader>v?r <Plug>VimCalcReplace
endif

if !hasmapto('<Plug>VimCalcReplaceWithSum','v')
  vmap  <leader>v?rs <Plug>VimCalcReplaceWithSum
endif

if !hasmapto('<Plug>VimCalcAppend','v')
  vmap  <leader>v? <Plug>VimCalcAppend
endif

if !hasmapto('<Plug>VimCalcAppendWithEq','v')
  vmap  <leader>v?= <Plug>VimCalcAppendWithEq
endif

if !hasmapto('<Plug>VimCalcAppendWithSum','v')
  vmap  <leader>v?s <Plug>VimCalcAppendWithSum
endif

if !hasmapto('<Plug>VimCalcAppendWithEqAndSum','v')
  vmap  <leader>v?=s <Plug>VimCalcAppendWithEqAndSum
endif

"}}}

"default mappings for python
  "{{{
if !hasmapto('<Plug>PyCalcReplace','v')
  vmap  <leader>p?r <Plug>PyCalcReplace
endif

if !hasmapto('<Plug>PyCalcReplaceWithSum','v')
  vmap  <leader>p?rs <Plug>PyCalcReplaceWithSum
endif

if !hasmapto('<Plug>PyCalcAppend','v')
  vmap  <leader>p? <Plug>PyCalcAppend
endif

if !hasmapto('<Plug>PyCalcAppendWithEq','v')
  vmap  <leader>p?= <Plug>PyCalcAppendWithEq
endif

if !hasmapto('<Plug>PyCalcAppendWithSum','v')
  vmap  <leader>p?s <Plug>PyCalcAppendWithSum
endif

if !hasmapto('<Plug>PyCalcAppendWithEqAndSum','v')
  vmap  <leader>p?=s <Plug>PyCalcAppendWithEqAndSum
endif
"}}}

" vim: ts=2:sw=2:tw=78:fdm=marker:expandtab
