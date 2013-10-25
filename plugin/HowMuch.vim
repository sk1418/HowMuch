" HowMuch : calculate visual selected math expressions
" Author  : Kai Yuan <kent.yuan@gmail.com>
" Version : 1.0.0
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

vnoremap <Plug>AutoCalcReplace            :call HowMuch#HowMuch(0,0,0,'auto')<cr>
vnoremap <Plug>AutoCalcReplaceWithSum     :call HowMuch#HowMuch(0,0,1,'auto')<cr>
vnoremap <Plug>AutoCalcAppend             :call HowMuch#HowMuch(1,0,0,'auto')<cr>
vnoremap <Plug>AutoCalcAppendWithEq       :call HowMuch#HowMuch(1,1,0,'auto')<cr>
vnoremap <Plug>AutoCalcAppendWithSum      :call HowMuch#HowMuch(1,0,1,'auto')<cr>
vnoremap <Plug>AutoCalcAppendWithEqAndSum :call HowMuch#HowMuch(1,1,1,'auto')<cr>

vnoremap <Plug>BcCalcReplace              :call HowMuch#HowMuch(0,0,0,'bc')<cr>
vnoremap <Plug>BcCalcReplaceWithSum       :call HowMuch#HowMuch(0,0,1,'bc')<cr>
vnoremap <Plug>BcCalcAppend               :call HowMuch#HowMuch(1,0,0,'bc')<cr>
vnoremap <Plug>BcCalcAppendWithEq         :call HowMuch#HowMuch(1,1,0,'bc')<cr>
vnoremap <Plug>BcCalcAppendWithSum        :call HowMuch#HowMuch(1,0,1,'bc')<cr>
vnoremap <Plug>BcCalcAppendWithEqAndSum   :call HowMuch#HowMuch(1,1,1,'bc')<cr>


vnoremap <Plug>VimCalcReplace             :call HowMuch#HowMuch(0,0,0,'vim')<cr>
vnoremap <Plug>VimCalcReplaceWithSum      :call HowMuch#HowMuch(0,0,1,'vim')<cr>
vnoremap <Plug>VimCalcAppend              :call HowMuch#HowMuch(1,0,0,'vim')<cr>
vnoremap <Plug>VimCalcAppendWithEq        :call HowMuch#HowMuch(1,1,0,'vim')<cr>
vnoremap <Plug>VimCalcAppendWithSum       :call HowMuch#HowMuch(1,0,1,'vim')<cr>
vnoremap <Plug>VimCalcAppendWithEqAndSum  :call HowMuch#HowMuch(1,1,1,'vim')<cr>


if !hasmapto('<Plug>AutoCalcReplace','v')
  vmap <silent><unique> <leader>?r <Plug>AutoCalcReplace
endif
if !hasmapto('<silent><Plug>AutoCalcReplaceWithSum','v')
  vmap <silent><unique> <leader>?rs <Plug>AutoCalcReplaceWithSum
endif
if !hasmapto('<silent><Plug>AutoCalcAppend','v')
  vmap <silent><unique> <leader>? <Plug>AutoCalcAppend
endif

if !hasmapto('<silent><Plug>AutoCalcAppendWithEq','v')
  vmap  <silent><unique> <leader>?= <Plug>AutoCalcAppendWithEq
endif

if !hasmapto('<silent><Plug>AutoCalcAppendWithSum','v')
  vmap  <silent><unique> <leader>?s <Plug>AutoCalcAppendWithSum
endif

if !hasmapto('<silent><Plug>AutoCalcAppendWithEqAndSum','v')
  vmap  <silent><unique> <leader>?=s <Plug>AutoCalcAppendWithEqAndSum
endif

if !hasmapto('<silent><Plug>BcCalcReplace','v')
  vmap  <silent><unique> <leader>b?r <Plug>BcCalcReplace
endif

if !hasmapto('<silent><Plug>BcCalcReplaceWithSum','v')
  vmap  <silent><unique> <leader>b?rs <Plug>BcCalcReplaceWithSum
endif

if !hasmapto('<silent><Plug>BcCalcAppend','v')
  vmap  <silent><unique> <leader>b? <Plug>BcCalcAppend
endif

if !hasmapto('<silent><Plug>BcCalcAppendWithEq','v')
  vmap  <silent><unique> <leader>b?= <Plug>BcCalcAppendWithEq
endif

if !hasmapto('<silent><Plug>BcCalcAppendWithSum','v')
  vmap  <silent><unique> <leader>b?s <Plug>BcCalcAppendWithSum
endif

if !hasmapto('<silent><Plug>BcCalcAppendWithEqAndSum','v')
  vmap  <silent><unique> <leader>b?=s <Plug>BcCalcAppendWithEqAndSum
endif

if !hasmapto('<silent><Plug>VimCalcReplace','v')
  vmap  <silent><unique> <leader>v?r <Plug>VimCalcReplace
endif

if !hasmapto('<silent><Plug>VimCalcReplaceWithSum','v')
  vmap  <silent><unique> <leader>v?rs <Plug>VimCalcReplaceWithSum
endif

if !hasmapto('<silent><Plug>VimCalcAppend','v')
  vmap  <silent><unique> <leader>v? <Plug>VimCalcAppend
endif

if !hasmapto('<silent><Plug>VimCalcAppendWithEq','v')
  vmap  <silent><unique> <leader>v?= <Plug>VimCalcAppendWithEq
endif

if !hasmapto('<silent><Plug>VimCalcAppendWithSum','v')
  vmap  <silent><unique> <leader>v?s <Plug>VimCalcAppendWithSum
endif

if !hasmapto('<silent><Plug>VimCalcAppendWithEqAndSum','v')
  vmap  <silent><unique> <leader>v?=s <Plug>VimCalcAppendWithEqAndSum
endif


" vim: ts=2:sw=2:tw=78:fdm=marker:expandtab
