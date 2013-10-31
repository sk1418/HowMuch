if exists("g:loaded_HowMuch") 
"FIXME skip finish only for testing and development
  "finish
endif
let g:loaded_HowMuch = 1
"let g:HowMuch_debug=1

"//////////////////////////////////////////////////////////////////////
"                              Variables                              /
"//////////////////////////////////////////////////////////////////////
let g:HowMuch_scale   = exists('g:HowMuch_scale')?   g:HowMuch_scale   : 2
let g:HowMuch_debug   = exists('g:HowMuch_debug')?   g:HowMuch_debug   : 0
let g:HowMuch_auto_engines = exists('g:HowMuch_auto_engines')? g:HowMuch_auto_engines : ['bc', 'vim', 'py']

let g:HowMuch_engine_map = exists('g:HowMuch_engine_map')? g:HowMuch_engine_map : { 
            \'auto':function('HowMuch#calc_auto'), 
            \ 'bc':function('HowMuch#calc_in_bc'),  
            \ 'py':function('HowMuch#calc_in_py'),  
            \ 'vim':function('HowMuch#calc_in_vim') }

"//////////////////////////////////////////////////////////////////////
"                         Helper  functions                         {{{
"//////////////////////////////////////////////////////////////////////

"============================
" print debug information
"============================
function! HowMuch#debug(prompt, msg)
  if g:HowMuch_debug
    echom printf( '[HowMuch Debug] %s :%s[$]', a:prompt, a:msg)
  endif
endfunction

"============================
" build HowMuch error message
"============================
function! HowMuch#errMsg(msg)
  return printf( '[HowMuch Error] %s',  a:msg)
endfunction


"============================
" Validate user's engine list
"============================
function! HowMuch#check_user_engines()
  if len(g:HowMuch_auto_engines)==0
    throw HowMuch#errMsg('Empty g:HowMuch_auto_engines is not allowed.')
  endif
  for k in g:HowMuch_auto_engines
    if !exists('g:HowMuch_engine_map[tolower(k)]') || tolower(k) =="auto"
      throw HowMuch#errMsg('Unsupported engine:'.k)
    endif
  endfor
endfunction


"============================
" change the numbers into float, 
" useful for vim engine to get the
" right scale
"============================
function! HowMuch#to_float(expr)
  return  substitute(a:expr,'[^.0-9^]\zs\d\+\ze\([^.0-9]\|$\)', '&.0', 'g')
endfunction


" if number in format ###.000, remove the trailing zeros
function! HowMuch#removeTrailingZero(float)
  return  substitute(a:float,'\.0*$', '', '')
endfunction

"============================
" get visual selected text
"============================
function! HowMuch#get_visual_text()
  try
    let v_save = @v
    normal! gv"vy
    return @v
  finally
    let @v = v_save
  endtry
endfunction 


"///////////////////////////////////////////////////////////////////}}}


"//////////////////////////////////////////////////////////////////////
"                          Logic   functions                          /
"//////////////////////////////////////////////////////////////////////
"============================
" main funciton, do calculation on expressions. The funciton has 4 arguments:
" isAppend: 
"           1: the result will be appended after the expression
"           0: the result will replace visual selected expression
" withEq :
"           This argument has effect only if isAppend is 1, it defines the
"           separtor between expression and appened result.
"           1: separator is ' = ' (space equal sign space)
"           0: separator is a space.
"
" sum:    
"           1: after the calculation of all expressions, do a SUM
"           0: without doing sum calculation.
"
" engineType: 
"           see variable g:HowMuch_engine_map, it defines that use which
"           engine to calculate the result.  If the value is 'auto', it will try engines
"           (also follow the order) defined in g:HowMuch_auto_engines
"============================
function! HowMuch#HowMuch(isAppend, withEq, sum, engineType) range

  "if do sum in wrong mode, reject
  if a:sum && visualmode() ==# 'v'
    echoerr HowMuch#errMsg('Sum feature is available only for line(V)/blockwise(<C-V>) visual mode')
    return
  endif

  let has_err      = 0
  let total        = 0.0
  "max_len is the length of longest line
  let max_len      = 0
  "first do validation
  try
    call HowMuch#check_user_engines()
  catch /HowMuch Error/
    echoerr v:exception
    return
  endtry
  let s = HowMuch#get_visual_text()
  let exps = split(s,'\n')

  "remove ending equals if there are
  call map(exps, 'substitute(v:val,"[\\\\t =]*$","","")')

  "better alignment for V and C-V
  " find the max_len
  if a:isAppend && (visualmode() == 'V' || visualmode() == '')
    for i in range(len(exps))
      let max_len = len(exps[i])>max_len? len(exps[i]):max_len
    endfor
    let exps = map(exps, "v:val . repeat(' ', max_len-len(v:val))")
  endif

  for i in range(len(exps))
    try
      "using a tmp value to store modified expression (to float)
      let e       = HowMuch#to_float(exps[i])
      call HowMuch#debug("after to_float:", e)
      let result  = g:HowMuch_engine_map[tolower(a:engineType)](e)
      let has_err = has_err>0? has_err : (result == 'Err'? 1:0)
      if !has_err && a:sum
        call HowMuch#debug('before adding to total, result:', result)
        call HowMuch#debug('result type:', type(result))
        let total +=  str2float(result)
        call HowMuch#debug('after adding total, total:', string(total))
      endif
    catch /.*/	
      let has_err +=1
      let result = 'Err'
      "echoerr  v:exception
    finally  "at the end prepare output
      if a:isAppend
        let exps[i] = exps[i] . (a:withEq?' = ':' ' ) .  result
      else
        let exps[i] = result
      endif
    endtry
  endfor

  if a:sum
    if has_err
     unlet total
     let total = 'Err' 
    endif
    "let total = has_err>0 ? 'Err': total
    call add(exps,repeat('-',max_len +2 ))
    if a:isAppend
      call add(exps,'Sum' . repeat(' ', max_len-3). (a:withEq?' = ':' ' ) . (type(total)==type("") ? total : string(total)) )
    else
      call add(exps,'Sum: ' .  (type(total)==type("") ? total : string(total) ))
    endif
  endif

  let s = join(exps, "\n")
  call HowMuch#debug('last big expr string', s)
  let v_save = @v
  call setreg('v',s,visualmode())
  "add two empty lines if sum is true
  if a:sum
    exec a:lastline.'pu _'
    exec a:lastline.'pu _'
  endif

  normal! gv"vp
  "restore the register (v) original value
  let @v = v_save
endfunction

"============================
" Do automatically calculation
" Auto-Calc will pick engine from the user defined engine list 
" in order, to do calculation. The first result without error will
" be returned
" HowMuch#calc_auto doesn't throw any exception
" =============================
function! HowMuch#calc_auto(expr)
  let errCount = 0
  let r = ''
  for e in g:HowMuch_auto_engines
    try
      call HowMuch#debug('Auto expr', a:expr)
      let r = g:HowMuch_engine_map[tolower(e)](a:expr)
      call HowMuch#debug('Auto result', r)
      return r
    catch /.*/
      let errCount += 1
      call HowMuch#debug("Auto Exception",v:exception)
      "return Err without stopping further calculation
      if errCount == len(g:HowMuch_auto_engines)
        return "Err"
      endif
    endtry
  endfor
endfunction

"============================
"evaluation the expression with vim 
"============================
function! HowMuch#calc_in_vim(expr)
  try
    call HowMuch#debug('Expression for vim', a:expr)
    let r = substitute(printf('%.'. g:HowMuch_scale . 'f', eval(a:expr)), '\.0*$', '', '') . ' '
    call HowMuch#debug('vim Result', r )
    return r
  catch /.*/
    throw HowMuch#errMsg('Invalid Vim Expression:'. a:expr .  ' Exception:' . v:exception)
  endtry
endfunction
"

"============================
"do math calculation with gnu bc -l
"Note: echo 'abc'|bc -l will return 0
"============================ 
function! HowMuch#calc_in_bc(expr)
  let r = system(printf('echo "scale=%d;%s"|bc -l &2>/dev/null', g:HowMuch_scale, a:expr))
  if v:shell_error>0
    throw HowMuch#errMsg('bc program return error: '. v:shell_error)
  elseif match(r, 'error')>0 || r == ''
    throw HowMuch#errMsg('Invalid bc Expression')
  endif
  "removing the ending line break
  let r = substitute(r, '[\n\r]*$', '', '')
  return HowMuch#removeTrailingZero(r)
endfunction

"============================
"do math calculation with python
"
"============================ 
function! HowMuch#calc_in_py(expr)
  if !has('python')
    echoerr HowMuch#errMsg('vim was not compiled with +python!')
    return 'Err'
  endif
  call HowMuch#debug('Expression for python', a:expr)
  let result = ''
python << EOF
import vim
import math
import re

# only math module is allowed for evaluation
ns = vars(math).copy()
ns['__builtins__'] = None
expr = vim.eval("a:expr")
scale = vim.eval("g:HowMuch_scale")
try:
    fmt    = "{:." + str(scale) + "f}"
    result = fmt.format(eval(expr,ns))
    # if number in format ###.000, remove the trailing zeros
except Exception as e:
    result = "Err"

vim.command("let result = string(%s)" % str(result))
EOF

    
  call HowMuch#debug('Result from python', result)
  if result == 'Err'
      throw HowMuch#errMsg('Invalid python Expression ' . a:expr)
  endif
  return HowMuch#removeTrailingZero(result)
endfunction

" vim: ts=2:sw=2:tw=78:fdm=marker:expandtab
