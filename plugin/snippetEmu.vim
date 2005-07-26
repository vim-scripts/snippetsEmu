" This file contains some simple functions that attempt to emulate some of the 
" behaviour of 'Snippets' from the OS X editor TextMate, in particular the
" variable bouncing and replacement behaviour.
"
" This is the first release and so is a bit rough around the edges.
"
" USAGE:
"
" 'source' the file and define your 'snippets' using the Iabbr command.
" The syntax of the command is the same as for 'iabbr'.
" Variables are tagged with @'s.
"
" Example:
" 
" Iabbr forin for @element@ in @collection@@element@.@@end
"
" The above will expand to the following (indenting may differ):
" 
" for @element@ in @collection@
" 	@element@.@@
" end
" 
" The cursor will be placed after the first @ in insert mode.
" Pressing <S-Del> will 'tab' to the next place marker (@collection@) in
" insert mode.  Adding text between the @@s and then hitting <S-Del> will
" remove the @s and replace all markers with a similar identifier.
"
" Eg:
" With the cursor at the pipe, hitting <S-Del> will replace:
" for @MyVariableName|element@ in @collection@
" 	@element@.@@
" end
"
" with (the pipe shows the cursor placement):
"
" for MyVariableName in @|collection@
" 	MyVariableName.@@
" end
" 
" Enjoy.
"
function! SetCom(text)
		return "iabbr ".substitute(a:text," "," :call SetPos()i","").":call SetVar()<C-R>=Eatchar('\\s')<CR>"
endfunction

function! SetPos()
		let b:curCurs = col(".")
		let b:curLine = line(".")
endfunction

function! SetVar()
		call cursor(b:curLine, 1)
		let line = getline(".")
		let b:var = matchstr(line,"@[^@]*@") 
		let b:var = strpart(b:var,1,strlen(b:var) - 2)
		"call search(b:var,"W")
		call search("@[^@]*@","W")
		execute "normal l"
		startinsert
endfunction

function! Jumper()
		let curCurs = col(".")
		let curLine = line(".")
		let line = getline(".")
		if line[col(".") - 1] == "@"
				call search("@[^@]*@")
				let b:var = matchstr(getline("."),"@[^@]*@") 
				let b:var = strpart(b:var,1,strlen(b:var) - 2)
				normal l
				startinsert
		elseif line[col(".")] == "@"
				execute "normal lxF@x"
				if search("@[^@]*@","W") > 0
					let b:var = matchstr(getline("."),"@[^@]*@") 
					let b:var = strpart(b:var,1,strlen(b:var) - 2)
					execute "normal l"
					startinsert
				else
					call cursor(curLine,curCurs)
					startinsert
				endif
		else
				let b:substr = strpart(line,0,col("."))
				let b:start = strridx(b:substr,"@") + 1
				let b:substr = strpart(b:substr,b:start,col(".") - b:start)
				while search("@".b:var."@","W") > 0
						execute "s/@".b:var."@/".b:substr."/g"
				endwhile
				call cursor(curLine, curCurs)
				execute "normal ld/@xF@x"
				if search("@[^@]*@","W") > 0
					let b:var = matchstr(getline("."),"@[^@]*@") 
					let b:var = strpart(b:var,1,strlen(b:var) - 2)
					execute "normal l"
					startinsert
				else
					startinsert
				endif
		endif
endfunction

" Set up the command.
command! -nargs=+ Iabbr execute SetCom(<q-args>)

"The following two functions are from Benji Fisher's foo.vim - a very helpful file
" The built-in getchar() function returns a Number for an 8-bit character, and
" a String for any other character.  This version always returns a String.
fun! Getchar()
  let c = getchar()
  if c != 0
    let c = nr2char(c)
  endif
  return c
endfun

fun! Eatchar(pat)
   let c = Getchar()
   return (c =~ a:pat) ? '' : c
endfun

" Map <S-Del> to call the Jumping function
imap <S-Del> :call Jumper()

" Abbreviations are set up as usual but using the Iabbr command rather
" than iabbr.  Formatting needs to be done as usual, hence the '<<'s and
" similar.  Not sure how well @ works as a delimiter but it can be changed
"Iabbr forin for @element@ in @collection@	@element@.@@end<<
"Iabbr select select { \|@element@\| @element@.@@ }
