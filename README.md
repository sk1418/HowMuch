**HowMuch** README file
	
	    __  __              __  ___           __       ___ 
	   / / / /___ _      __/  |/  /_  _______/ /_     /__ \
	  / /_/ / __ \ | /| / / /|_/ / / / / ___/ __ \     / _/
	 / __  / /_/ / |/ |/ / /  / / /_/ / /__/ / / /    /_/  
	/_/ /_/\\___/|_\/|__/_/  /\\\__,_/\___/_/ /_/    (_)  
	
	- calculate visual selected math expressions in vim	
                                                     

#!!!HowMuch is still under developement!!!
	!
#Introduction
`HowMuch` is a Vim plugin to calculate visual selected mathematical formulars (vim or bc expressions). It will add the result(or replace the selected expressions) in the current edit text. For details check next section: Features 

#Features

- Supports all visual selection modes (char-/line-/block-wise)
- Supports two output formats: 
	- append result with/out `=` after the expression 
	- replace the selected expressions with result
- Supports sum total result in line-(`v`) and block-wise (`Ctrl-v`)selection
- User can create custom mapping to invoke `HowMuch`
- *Evaluation "Engines"*
	- `HowMuch` supports `GNU bc` and `vim` expressions evaluation engines,
	- User can choose which engine should be used to evaluate current visual section.
	- User can define the order of the engines, and let `HowMuch` do evaluation automatically. E.g. if `bc` fails, try `vim` again.

#Examples & Screencasts
Examples and screencasts would be the best way to explain how does `HowMuch` does it job. For detailed usage explanation, please check the plugin documentation. The **USAGE*** section in the doc will cover:

- what mapping gets what output
- set `HowMuch` varialbes
- create custom `HowMuch` mappings

screencasts TODO

#About Engines
todo(vim, bc, python?)



