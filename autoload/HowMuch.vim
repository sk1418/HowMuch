"//////////////////////////////////////////////////////////////////////
"                              Variables                              /
"//////////////////////////////////////////////////////////////////////
let g:HowMuch_debug   = 1
let g:HowMuch_scale   = exists('g : HowMuch_scale')?   g:HowMuch_scale   : 2
"let g:HowMuch_debug   = exists('g : HowMuch_debug')?   g:HowMuch_debug   : 0
let g:HowMuch_auto_engines = exists('g : HowMuch_auto_engines')? g:HowMuch_auto_engines : ['bc', 'vim']

let s:engineMap = { 'auto':function('HowMuch#calc_auto'), 
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
	return  substitute(a:expr,'[^.0-9]\zs\d\+\ze[^.0-9]', '&.0', 'g')
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
" TODO argument description
"============================
function! HowMuch#HowMuch(isAppend, withEq, sum, engineType)
	"first do validation
	try
		call HowMuch#check_user_engines()
	catch /HowMuch Error/
		echoerr v:exception
		return
	endtry
	let s = HowMuch#get_visual_text()
	let exps = split(s,'\n')
	for i in range(len(exps))
		try
			"remove ending equals if there are
			let exps[i] = substitute(exps[i],"[\t =]*$",'','g')
			"using a tmp value to store modified expression (to float)
			let e = HowMuch#to_float(exps[i])
			"let exps[i] = exps[i] . (a:withEq?' = ':' ' ) . HowMuch#calc_in_vim(e)

			if a:isAppend
				let exps[i] = exps[i] . (a:withEq?' = ':' ' ) .  s:engineMap[tolower(a:engineType)](e)
			else
				let exps[i] = s:engineMap[tolower(a:engineType)](e)
			endif
		catch /.*/	
			echoerr  v:exception
			return
		endtry
	endfor
	let s = join(exps, "\n")
	let v_save = @v
	call setreg('v',s,visualmode())
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
    call Debug ('Expression for vim', a:expr)
    "remove precision if the number is ending with '.00000'
    return  substitute(printf('%.'.g:HowMuch_scale . 'f', eval(a:expr)), '\.0*$', '', '') . ' '
  catch /^Vim/
    throw HowMuch#errMsg('Invalid Vim Expression')
  endtry
endfunction

"============================
"do math calculation with gnu bc -l
"Note: echo 'abc'|bc -l will return 0
"============================
function! HowMuch#calc_in_bc(expr)
	let r = system(printf('echo "scale=%d;%s"|bc -l', g:HowMuch_scale, a:expr))
	call HowMuch#debug('Bc expression', a:expr)
	if match(r, 'error')>0
		throw HowMuch#errMsg('Invalid bc Expression')
	endif
	"removing the ending line break
	let r = substitute(r, '[\n\r]*$', '', '')
	return r
endfunction


function! HowMuch#calc_in_py(expr)
	let r = system(printf('echo "scale=%d;%s"|bc -l', g:HowMuch_scale, a:expr))
	call HowMuch#debug('Bc expression', a:expr)
	if match(r, 'error')>0
		throw HowMuch#errMsg('Invalid bc Expression')
	endif
	"removing the ending line break
	let r = substitute(r, '[\n\r]*$', '', '')
	return r
endfunction



vnoremap <leader>? :<c-u>call HowMuch#HowMuch(1,1,0,'auto')<cr>
" vim: ts=2:sw=2:tw=78:fdm=marker:expandtab
