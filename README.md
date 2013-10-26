**HowMuch** README file
	
	    __  __              __  ___           __       ___ 
	   / / / /___ _      __/  |/  /_  _______/ /_     /__ \
	  / /_/ / __ \ | /| / / /|_/ / / / / ___/ __ \     / _/
	 / __  / /_/ / |/ |/ / /  / / /_/ / /__/ / / /    /_/  
	/_/ /_/\\___/|_\/|__/_/  /\\\__,_/\___/_/ /_/    (_)  
	
	- calculate visual selected math expressions in vim	
                                                     

#HowMuch

#Introduction
`HowMuch` is a Vim plugin to calculate visual selected mathematical formulars (vim or bc expressions). It will add the result(or replace the selected expressions) in the current edit text. For details check next section: Features 

#Features

- Support
	* Engines
	- `HowMuch` supports `GNU bc` and `vim` expressions evaluation *"engines"*,
	- User can choose which engine should be used to evaluate current visual section.
	- User can define the order of the engines, and let `HowMuch` do evaluation automatically. E.g. if `bc` fails, try `vim` again.

#Demos

#Why there is only `bc` and `Vim` expression evaluation? How about `python`, `ruby`,`javascript`....?


