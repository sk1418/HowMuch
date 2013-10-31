**HowMuch** README file
	

	    __  __              __  ___           __       ___ 
	   / / / /___ _      __/  |/  /_  _______/ /_     /__ \
	  / /_/ / __ \ | /| / / /|_/ / / / / ___/ __ \     / _/
	 / __  / /_/ / |/ |/ / /  / / /_/ / /__/ / / /    /_/  
	/_/ /_/\____/|__/|__/_/  /_/\__,_/\___/_/ /_/    (_) 

	  - A Vim calculator for visual selections

                                                     

##!HowMuch is still under development!
##Introduction
`HowMuch` is a Vim plugin to calculate visual selected mathematical formulars (vim or bc expressions). It will add the result(or replace the selected expressions) in the current edit text. For details check next section: Features 

##Features

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

##Examples & Screencasts
Examples and screencasts would be the best way to explain how does `HowMuch` does it job. In the demo section, only Auto-Calc will be demoed. The calculation can be done by certain engine. E.g 

- `<leader>b?` for `bc`
- `<leader>v?` for `vim`
- `<leader>p?` for `python`

Details please check plugin documentation.

All demos were made with following settings.

	"The scale of the result:
	let g:HowMuch_scale = 2 
	"the engine order for auto-calculation
	let g:HowMuch_auto_engines = ['bc', 'vim', 'py']


###Auto-Calc Demo
Auto-calc will evaluate each expression with each engine in turn, taking order from `g:HowMuch_auto_engines`, till a result without error comes out. If all engines give `Err`. E.g an expression like `##+foo`, result is `Err`. 

As long as there was an `Err`, the result of `sum` would be `Err`

####Demo 1:
- block-wise selection (`Ctrl-V`)
- Append result after each expression, separated with '=', 
- default mapping: `<Leader>?=`
![demo1](https://raw.github.com/sk1418/HowMuch/master/demo/demo1.gif)

####Demo 2:
- block-wise selection (`Ctrl-V`)
- replace selected expressions with result
- default mapping: <Leader>?r
![demo2](https://raw.github.com/sk1418/HowMuch/master/demo/demo2.gif)

####Demo 3:
- block-wise selection (`Ctrl-V`)
- append result after each expressions (with **Err**)
- do sum (with **Err**)
- default mapping: <Leader>?s
![demo3](https://raw.github.com/sk1418/HowMuch/master/demo/demo3.gif)

####Demo 4:
- block-wise selection (`Ctrl-V`)
- replace selected expressions with result
- do sum 
- default mapping: <Leader>?rs
![demo4](https://raw.github.com/sk1418/HowMuch/master/demo/demo4.gif)

####Demo 5:
- block-wise selection (`Ctrl-V`)
- Append result after each expression, separated with '=', 
- do sum
- default mapping: `<Leader>?=s`
![demo5](https://raw.github.com/sk1418/HowMuch/master/demo/demo5.gif)





