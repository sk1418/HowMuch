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
if exists("g:loaded_HowMuch") 
  finish
endif
let g:loaded_HowMuch = 1

let s:version ="1.0.1"
"command to check version
command! HowMuchVersion echo "HowMuch Version: " . s:version
":HowMuch command
command! -range -nargs=* HowMuch call HowMuch#DoWithCommand(<q-args>)

"<Plug> mappings for auto engine
"{{{
vnoremap <silent><unique> <Plug>AutoCalcReplace            :call HowMuch#HowMuch(0,0,0,'auto')<cr>
vnoremap <silent><unique> <Plug>AutoCalcWithSumReplace     :call HowMuch#HowMuch(0,0,1,'auto')<cr>
vnoremap <silent><unique> <Plug>AutoCalcAppend             :call HowMuch#HowMuch(1,0,0,'auto')<cr>
vnoremap <silent><unique> <Plug>AutoCalcWithEqAppend       :call HowMuch#HowMuch(1,1,0,'auto')<cr>
vnoremap <silent><unique> <Plug>AutoCalcWithSumAppend      :call HowMuch#HowMuch(1,0,1,'auto')<cr>
vnoremap <silent><unique> <Plug>AutoCalcWithEqAndSumAppend :call HowMuch#HowMuch(1,1,1,'auto')<cr>
"}}}

"<Plug> mappings for bc engine
"{{{
vnoremap <silent><unique> <Plug>BcCalcReplace              :call HowMuch#HowMuch(0,0,0,'bc')<cr>
vnoremap <silent><unique> <Plug>BcCalcWithSumReplace       :call HowMuch#HowMuch(0,0,1,'bc')<cr>
vnoremap <silent><unique> <Plug>BcCalcAppend               :call HowMuch#HowMuch(1,0,0,'bc')<cr>
vnoremap <silent><unique> <Plug>BcCalcWithEqAppend         :call HowMuch#HowMuch(1,1,0,'bc')<cr>
vnoremap <silent><unique> <Plug>BcCalcWithSumAppend        :call HowMuch#HowMuch(1,0,1,'bc')<cr>
vnoremap <silent><unique> <Plug>BcCalcWithEqAndSumAppend   :call HowMuch#HowMuch(1,1,1,'bc')<cr>
"}}}

"<Plug> mappings for vim engine
"{{{
vnoremap <silent><unique> <Plug>VimCalcReplace             :call HowMuch#HowMuch(0,0,0,'vim')<cr>
vnoremap <silent><unique> <Plug>VimCalcWithSumReplace      :call HowMuch#HowMuch(0,0,1,'vim')<cr>
vnoremap <silent><unique> <Plug>VimCalcAppend              :call HowMuch#HowMuch(1,0,0,'vim')<cr>
vnoremap <silent><unique> <Plug>VimCalcWithEqAppend        :call HowMuch#HowMuch(1,1,0,'vim')<cr>
vnoremap <silent><unique> <Plug>VimCalcWithSumAppend       :call HowMuch#HowMuch(1,0,1,'vim')<cr>
vnoremap <silent><unique> <Plug>VimCalcWithEqAndSumAppend  :call HowMuch#HowMuch(1,1,1,'vim')<cr>
"}}}

"<Plug> mappings for python engine
"{{{
vnoremap <silent><unique> <Plug>PyCalcReplace              :call HowMuch#HowMuch(0,0,0,'py')<cr>
vnoremap <silent><unique> <Plug>PyCalcWithSumReplace       :call HowMuch#HowMuch(0,0,1,'py')<cr>
vnoremap <silent><unique> <Plug>PyCalcAppend               :call HowMuch#HowMuch(1,0,0,'py')<cr>
vnoremap <silent><unique> <Plug>PyCalcWithEqAppend         :call HowMuch#HowMuch(1,1,0,'py')<cr>
vnoremap <silent><unique> <Plug>PyCalcWithSumAppend        :call HowMuch#HowMuch(1,0,1,'py')<cr>
vnoremap <silent><unique> <Plug>PyCalcWithEqAndSumAppend   :call HowMuch#HowMuch(1,1,1,'py')<cr>
"}}}

"===========================================================

"default mappings for auto
"{{{
if !hasmapto('<Plug>AutoCalcReplace','v')
  vmap <leader>?r <Plug>AutoCalcReplace
endif
if !hasmapto('<Plug>AutoCalcWithSumReplace','v')
  vmap <leader>?sr <Plug>AutoCalcWithSumReplace
endif
if !hasmapto('<Plug>AutoCalcAppend','v')
  vmap <leader>?a <Plug>AutoCalcAppend
endif

if !hasmapto('<Plug>AutoCalcWithEqAppend','v')
  vmap  <leader>?=a <Plug>AutoCalcWithEqAppend
endif

if !hasmapto('<Plug>AutoCalcWithSumAppend','v')
  vmap  <leader>?sa <Plug>AutoCalcWithSumAppend
endif

if !hasmapto('<Plug>AutoCalcWithEqAndSumAppend','v')
  vmap  <leader>?=sa <Plug>AutoCalcWithEqAndSumAppend
endif"}}}

"default mappings for bc
"{{{
if !hasmapto('<Plug>BcCalcReplace','v')
  vmap  <leader>b?r <Plug>BcCalcReplace
endif

if !hasmapto('<Plug>BcCalcWithSumReplace','v')
  vmap  <leader>b?sr <Plug>BcCalcWithSumReplace
endif

if !hasmapto('<Plug>BcCalcAppend','v')
  vmap  <leader>b?a <Plug>BcCalcAppend
endif

if !hasmapto('<Plug>BcCalcWithEqAppend','v')
  vmap  <leader>b?=a <Plug>BcCalcWithEqAppend
endif

if !hasmapto('<Plug>BcCalcWithSumAppend','v')
  vmap  <leader>b?sa <Plug>BcCalcWithSumAppend
endif

if !hasmapto('<Plug>BcCalcWithEqAndSumAppend','v')
  vmap  <leader>b?=sa <Plug>BcCalcWithEqAndSumAppend
endif"}}}

"default mappings for vim
"{{{
if !hasmapto('<Plug>VimCalcReplace','v')
  vmap  <leader>v?r <Plug>VimCalcReplace
endif

if !hasmapto('<Plug>VimCalcWithSumReplace','v')
  vmap  <leader>v?sr <Plug>VimCalcWithSumReplace
endif

if !hasmapto('<Plug>VimCalcAppend','v')
  vmap  <leader>v?a <Plug>VimCalcAppend
endif

if !hasmapto('<Plug>VimCalcWithEqAppend','v')
  vmap  <leader>v?=a <Plug>VimCalcWithEqAppend
endif

if !hasmapto('<Plug>VimCalcWithSumAppend','v')
  vmap  <leader>v?sa <Plug>VimCalcWithSumAppend
endif

if !hasmapto('<Plug>VimCalcWithEqAndSumAppend','v')
  vmap  <leader>v?=sa <Plug>VimCalcWithEqAndSumAppend
endif

"}}}

"default mappings for python
  "{{{
if !hasmapto('<Plug>PyCalcReplace','v')
  vmap  <leader>p?r <Plug>PyCalcReplace
endif

if !hasmapto('<Plug>PyCalcWithSumReplace','v')
  vmap  <leader>p?sr <Plug>PyCalcWithSumReplace
endif

if !hasmapto('<Plug>PyCalcAppend','v')
  vmap  <leader>p?a <Plug>PyCalcAppend
endif

if !hasmapto('<Plug>PyCalcWithEqAppend','v')
  vmap  <leader>p?=a <Plug>PyCalcWithEqAppend
endif

if !hasmapto('<Plug>PyCalcWithSumAppend','v')
  vmap  <leader>p?sa <Plug>PyCalcWithSumAppend
endif

if !hasmapto('<Plug>PyCalcWithEqAndSumAppend','v')
  vmap  <leader>p?=sa <Plug>PyCalcWithEqAndSumAppend
endif
"}}}

" vim: ts=2:sw=2:tw=78:fdm=marker:expandtab
