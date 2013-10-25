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


function! HowMuchN(isAppend, withEq, isSum, type)
  call HowMuch#HowMuch(a:isAppend,a:withEq,a:isSum,a:type)
endfunction

vnoremap <Plug>AutoCalcReplace            :call HowMuchN(0,0,0,'auto')<cr>
vnoremap <Plug>AutoCalcReplaceWithSum     :call HowMuchN(0,0,1,'auto')<cr>
vnoremap <Plug>AutoCalcAppend             :call HowMuchN(1,0,0,'auto')<cr>
vnoremap <Plug>AutoCalcAppendWithEq       :call HowMuchN(1,1,0,'auto')<cr>
vnoremap <Plug>AutoCalcAppendWithSum      :call HowMuchN(1,0,1,'auto')<cr>
vnoremap <Plug>AutoCalcAppendWithEqAndSum :call HowMuchN(1,1,1,'auto')<cr>

vnoremap <Plug>BcCalcReplace              :call HowMuchN(0,0,0,'bc')<cr>
vnoremap <Plug>BcCalcReplaceWithSum       :call HowMuchN(0,0,1,'bc')<cr>
vnoremap <Plug>BcCalcAppend               :call HowMuchN(1,0,0,'bc')<cr>
vnoremap <Plug>BcCalcAppendWithEq         :call HowMuchN(1,1,0,'bc')<cr>
vnoremap <Plug>BcCalcAppendWithSum        :call HowMuchN(1,0,1,'bc')<cr>
vnoremap <Plug>BcCalcAppendWithEqAndSum   :call HowMuchN(1,1,1,'bc')<cr>


vnoremap <Plug>VimCalcReplace             :call HowMuchN(0,0,0,'vim')<cr>
vnoremap <Plug>VimCalcReplaceWithSum      :call HowMuchN(0,0,1,'vim')<cr>
vnoremap <Plug>VimCalcAppend              :call HowMuchN(1,0,0,'vim')<cr>
vnoremap <Plug>VimCalcAppendWithEq        :call HowMuchN(1,1,0,'vim')<cr>
vnoremap <Plug>VimCalcAppendWithSum       :call HowMuchN(1,0,1,'vim')<cr>
vnoremap <Plug>VimCalcAppendWithEqAndSum  :call HowMuchN(1,1,1,'vim')<cr>


if !hasmapto('<Plug>AutoCalcReplace','v')
  vmap <unique> <leader>?r <Plug>AutoCalcReplace
endif
if !hasmapto('<Plug>AutoCalcReplaceWithSum','v')
  vmap <unique> <leader>?rs <Plug>AutoCalcReplaceWithSum
endif
if !hasmapto('<Plug>AutoCalcAppend','v')
  vmap <unique> <leader>? <Plug>AutoCalcAppend
endif

if !hasmapto('<Plug>AutoCalcAppendWithEq','v')
  vmap  <unique> <leader>?= <Plug>AutoCalcAppendWithEq
endif

if !hasmapto('<Plug>AutoCalcAppendWithSum','v')
  vmap  <unique> <leader>?s <Plug>AutoCalcAppendWithSum
endif

if !hasmapto('<Plug>AutoCalcAppendWithEqAndSum','v')
  vmap  <unique> <leader>?=s <Plug>AutoCalcAppendWithEqAndSum
endif

if !hasmapto('<Plug>BcCalcReplace','v')
  vmap  <unique> <leader>b?r <Plug>BcCalcReplace
endif

if !hasmapto('<Plug>BcCalcReplaceWithSum','v')
  vmap  <unique> <leader>b?rs <Plug>BcCalcReplaceWithSum
endif

if !hasmapto('<Plug>BcCalcAppend','v')
  vmap  <unique> <leader>b? <Plug>BcCalcAppend
endif

if !hasmapto('<Plug>BcCalcAppendWithEq','v')
  vmap  <unique> <leader>b?= <Plug>BcCalcAppendWithEq
endif

if !hasmapto('<Plug>BcCalcAppendWithSum','v')
  vmap  <unique> <leader>b?s <Plug>BcCalcAppendWithSum
endif

if !hasmapto('<Plug>BcCalcAppendWithEqAndSum','v')
  vmap  <unique> <leader>b?=s <Plug>BcCalcAppendWithEqAndSum
endif

if !hasmapto('<Plug>VimCalcReplace','v')
  vmap  <unique> <leader>v?r <Plug>VimCalcReplace
endif

if !hasmapto('<Plug>VimCalcReplaceWithSum','v')
  vmap  <unique> <leader>v?rs <Plug>VimCalcReplaceWithSum
endif

if !hasmapto('<Plug>VimCalcAppend','v')
  vmap  <unique> <leader>v? <Plug>VimCalcAppend
endif

if !hasmapto('<Plug>VimCalcAppendWithEq','v')
  vmap  <unique> <leader>v?= <Plug>VimCalcAppendWithEq
endif

if !hasmapto('<Plug>VimCalcAppendWithSum','v')
  vmap  <unique> <leader>v?s <Plug>VimCalcAppendWithSum
endif

if !hasmapto('<Plug>VimCalcAppendWithEqAndSum','v')
  vmap  <unique> <leader>v?=s <Plug>VimCalcAppendWithEqAndSum
endif


" vim: ts=2:sw=2:tw=78:fdm=marker:expandtab
