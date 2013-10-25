"//////////////////////////////////////////////////////////////////////
"                              Variables                              /
"//////////////////////////////////////////////////////////////////////
let g:HowMuch_debug   = 1
let g:HowMuch_scale   = exists('g:HowMuch_scale')?   g:HowMuch_scale   : 2
let g:HowMuch_debug   = exists('g:HowMuch_debug')?   g:HowMuch_debug   : 0
let g:HowMuch_auto_engines = exists('g:HowMuch_auto_engines')? g:HowMuch_auto_engines : ['bc', 'vim']

let s:engineMap = { 'auto':function('HowMuch#calc_auto'), 
					\ 'bc':function('HowMuch#calc_in_bc'),  
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
		if !exists('s:engineMap[tolower(k)]') || tolower(k) =="auto"
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
" main funciton
" TODO argument description[doc]
"============================
function! HowMuch#HowMuch(isAppend, withEq, sum, engineType) range

  "if do sum in wrong mode, reject
  if a:sum && visualmode() ==# 'v'
    echoerr HowMuch#errMsg('Sum feature is available only for line(V)/blockwise(<C-V>) visual mode')
    return
  endif

  let has_err      = 0
  let total        = 0
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
        let result  = s:engineMap[tolower(a:engineType)](e)
        let has_err = has_err>0? has_err : (result == 'Err'? 1:0)
        if !has_err
          let total += str2float(result)
        endif
      catch /.*/	
        let has_err +=1
        let result = 'Err'
        call HowMuch#debug('result', result)
        "echoerr  v:exception
      finally  "at the end prepare output
        if a:isAppend
          let exps[i] = exps[i] . (a:withEq?' = ':' ' ) .  result
        else
          let exps[i] = result
        endif
      endtry
    endfor

    let total = has_err>0? 'Err':total
    if a:sum
      call add(exps,repeat('-',max_len +2 ))
      if a:isAppend
        call add(exps,'Sum' . repeat(' ', max_len-3). (a:withEq?' = ':' ' ) . string(total) )
      else
        call add(exps,'Sum: ' .  string(total) )
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
			let r = s:engineMap[tolower(e)](a:expr)
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
    "remove precision if the number is ending with '.00000'
    return r
  catch /.*/
    throw HowMuch#errMsg('Invalid Vim Expression:'. a:expr .  ' Exception:' . v:exception)
  endtry
endfunction

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
	return r
endfunction



"vnoremap <Plug>AutoCalcReplace :call HowMuch#HowMuch(0,0,0,'auto')<cr>
"vnoremap <Plug>AutoCalcReplaceWithSum :call HowMuch#HowMuch(0,0,1,'auto')<cr>
"vnoremap <Plug>AutoCalcAppend :call HowMuch#HowMuch(1,0,0,'auto')<cr>
"vnoremap <Plug>AutoCalcAppendWithEq :call HowMuch#HowMuch(1,1,0,'auto')<cr>
"vnoremap <Plug>AutoCalcAppendWithSum :call HowMuch#HowMuch(1,0,1,'auto')<cr>
"vnoremap <Plug>AutoCalcAppendWithEqAndSum :call HowMuch#HowMuch(1,1,1,'auto')<cr>

"vnoremap <Plug>BcCalcReplace :call HowMuch#HowMuch(0,0,0,'bc')<cr>
"vnoremap <Plug>BcCalcReplaceWithSum :call HowMuch#HowMuch(0,0,1,'bc')<cr>
"vnoremap <Plug>BcCalcAppend :call HowMuch#HowMuch(1,0,0,'bc')<cr>
"vnoremap <Plug>BcCalcAppendWithEq :call HowMuch#HowMuch(1,1,0,'bc')<cr>
"vnoremap <Plug>BcCalcAppendWithSum :call HowMuch#HowMuch(1,0,1,'bc')<cr>
"vnoremap <Plug>BcCalcAppendWithEqAndSum :call HowMuch#HowMuch(1,1,1,'bc')<cr>


"vnoremap <Plug>VimCalcReplace :call HowMuch#HowMuch(0,0,0,'vim')<cr>
"vnoremap <Plug>VimCalcReplaceWithSum :call HowMuch#HowMuch(0,0,1,'vim')<cr>
"vnoremap <Plug>VimCalcAppend :call HowMuch#HowMuch(1,0,0,'vim')<cr>
"vnoremap <Plug>VimCalcAppendWithEq :call HowMuch#HowMuch(1,1,0,'vim')<cr>
"vnoremap <Plug>VimCalcAppendWithSum :call HowMuch#HowMuch(1,0,1,'vim')<cr>
"vnoremap <Plug>VimCalcAppendWithEqAndSum :call HowMuch#HowMuch(1,1,1,'vim')<cr>
"nnoremap <Plug>X :ls<cr>
"nnoremap <leader>q <Plug>X


""if !hasmapto('<Plug>AutoCalcReplace')
  ""vnoremap   <leader>?r <Plug>AutoCalcReplace
""endif
""if !hasmapto('<Plug>AutoCalcReplaceWithSum')
  ""vnoremap   <leader>?rs <Plug>AutoCalcReplaceWithSum
""endif
"if !hasmapto('<Plug>AutoCalcAppend')
  "vnoremap   <leader>? <Plug>AutoCalcAppend
"endif

""if !hasmapto('<Plug>AutoCalcAppendWithEq')
  ""vnoremap   <leader>?= <Plug>AutoCalcAppendWithEq
""endif

""if !hasmapto('<Plug>AutoCalcAppendWithSum')
  ""vnoremap   <leader>?s <Plug>AutoCalcAppendWithSum
""endif

""if !hasmapto('<Plug>AutoCalcAppendWithEqAndSum')
  ""vnoremap   <leader>?=s <Plug>AutoCalcAppendWithEqAndSum
""endif

""if !hasmapto('<Plug>BcCalcReplace')
  ""vnoremap   <leader>b?r <Plug>BcCalcReplace
""endif

""if !hasmapto('<Plug>BcCalcReplaceWithSum')
  ""vnoremap   <leader>b?rs <Plug>BcCalcReplaceWithSum
""endif

""if !hasmapto('<Plug>BcCalcAppend')
  ""vnoremap   <leader>b? <Plug>BcCalcAppend
""endif

""if !hasmapto('<Plug>BcCalcAppendWithEq')
  ""vnoremap   <leader>b?= <Plug>BcCalcAppendWithEq
""endif

""if !hasmapto('<Plug>BcCalcAppendWithSum')
  ""vnoremap   <leader>b?s <Plug>BcCalcAppendWithSum
""endif

""if !hasmapto('<Plug>BcCalcAppendWithEqAndSum')
  ""vnoremap   <leader>b?=s <Plug>BcCalcAppendWithEqAndSum
""endif

""if !hasmapto('<Plug>VimCalcReplace')
  ""vnoremap   <leader>v?r <Plug>VimCalcReplace
""endif

""if !hasmapto('<Plug>VimCalcReplaceWithSum')
  ""vnoremap   <leader>v?rs <Plug>VimCalcReplaceWithSum
""endif

""if !hasmapto('<Plug>VimCalcAppend')
  ""vnoremap   <leader>v? <Plug>VimCalcAppend
""endif

""if !hasmapto('<Plug>VimCalcAppendWithEq')
  ""vnoremap   <leader>v?= <Plug>VimCalcAppendWithEq
""endif

""if !hasmapto('<Plug>VimCalcAppendWithSum')
  ""vnoremap   <leader>v?s <Plug>VimCalcAppendWithSum
""endif

""if !hasmapto('<Plug>VimCalcAppendWithEqAndSum')
  ""vnoremap   <leader>v?=s <Plug>VimCalcAppendWithEqAndSum
""endif



" vim: ts=2:sw=2:tw=78:fdm=marker:expandtab
