**HowMuch** README file
	

	    __  __              __  ___           __       ___ 
	   / / / /___ _      __/  |/  /_  _______/ /_     /__ \
	  / /_/ / __ \ | /| / / /|_/ / / / / ___/ __ \     / _/
	 / __  / /_/ / |/ |/ / /  / / /_/ / /__/ / / /    /_/  
	/_/ /_/\____/|__/|__/_/  /_/\__,_/\___/_/ /_/    (_) 

	  - A Vim calculator for visual selections

                                                     

#!HowMuch is still under development!
#Introduction
`HowMuch` is a Vim plugin to calculate visual selected mathematical formulars (vim or bc expressions). It will add the result(or replace the selected expressions) in the current edit text. For details check next section: Features 

#Features

- Supports all visual selection modes (char-/line-/block-wise)
- Supports two output formats: 
	- append result with/out `=` after the expression 
	- replace the selected expressions with result
- Supports sum total result in line-(`V`) and block-wise (`Ctrl-V`)selection
- User can create custom mapping to invoke `HowMuch`
- *Evaluation "Engines"* (The expression evaluator)
	- `HowMuch` supports `GNU bc`, `python` and `native vim` expressions evaluation engines,
	- User can choose which engine should be used to evaluate current visual section.
	- User can define the order of the engines, and let `HowMuch` do evaluation automatically. E.g. if `bc` fails, try `vim` again.

**!Please read plugin documentation for variables, mapping and cautions details**

#Examples & Screencasts
Examples and screencasts would be the best way to explain how does `HowMuch` does it job.

I have this settings in vimrc for the screencasts

	"The scale of the result:
	let g:HowMuch_scale = 2 
	"the engine order for auto-calculation
	let g:HowMuch_auto_engines = ['bc', 'vim', 'py']


##Auto-Calc Demo
Auto-calc will evaluate each expression with each engine in turn, taking order from `g:HowMuch_auto_engines`, till a result without error comes out. If all engines give `Err`. E.g an expression like `##+foo`, result is `Err`. 

As long as there was an `Err`, the result of `sum` would be `Err`

###Demo 1:
- block-wise selection (`Ctrl-V`)
- Append result after each expression, separted with '=', 
- default mapping: <Leader>?=
![Demo1](demo/demo1.gif, "Demo1")

###Demo 2:
- block-wise selection (`Ctrl-V`)
- replace selected expressions with result
- default mapping: <Leader>?r

###Demo 3:
- block-wise selection (`Ctrl-V`)
- append result after each expressions (with **Err**)
- do sum (with **Err**)
- default mapping: <Leader>?s


screencasts TODO


