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
"	@element@.@@
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
"	@element@.@@
" end
"
" with (the pipe shows the cursor placement):
"
" for MyVariableName in @|collection@
"	MyVariableName.@@
" end
" 
" Enjoy.
"

if !exists("g:snip_start_tag")
	let g:snip_start_tag = "<"
endif

if !exists("g:snip_end_tag")
	let g:snip_end_tag = ">"
endif

if !exists("g:snip_elem_delim")
	let g:snip_elem_delim = ":"
endif

let s:search_str = g:snip_start_tag."[^".g:snip_end_tag."]*".g:snip_end_tag
let s:search_defVal = "[^".g:snip_elem_delim."]*"
let s:search_endVal = "[^".g:snip_end_tag."]*"

function! SetCom(text)
	"return "iabbr ".substitute(a:text," "," :call SetPos()i","").":call SetVar()<C-R>=Eatchar('\\s')<CR>"
	return "iabbr ".substitute(a:text," "," :call SetPos()i","").":call MovePos()<C-R>=Eatchar('\\s')<CR>"
endfunction

function! SetPos()
		let b:curCurs = col(".")
		let b:curLine = line(".")
endfunction

function! MovePos()
	call cursor(b:curLine, 1)
	call search(s:search_str)
	if getline(".")[col(".") + 1] == g:snip_end_tag
		" We're at a type 1. tag
		normal xx
	elseif getline(".")[col(".") + 1] == g:snip_elem_delim && getline(".")[col(".") + 2] == g:snip_end_tag
		" We're at a "<:>" tag
		normal xxx
	endif
	normal l
	startinsert
endfunction

function! SetVar()
		call cursor(b:curLine, 1)
		let line = getline(".")
		let b:var = matchstr(line,g:snip_search_str) 
		"let b:var = matchstr(line,"@[^@]*@") 
		let b:var = strpart(b:var,1,strlen(b:var) - 2)
		"call search(b:var,"W")
		call search(g:snip_search_str,"W")
		"call search("@[^@]*@","W")
		execute "normal l"
		startinsert
endfunction

function! NextHop()
	call cursor(s:curLine, s:curCurs)
	if search(s:search_str) != 0
		if (col(".") + 1) == strlen(getline("."))
			let s:checkForEnd = 1
		elseif (getline(".")[col(".")] == g:snip_elem_delim) &&
					\(getline(".")[col(".") + 1] == g:snip_end_tag) &&
					\(col(".") + 2 ==strlen(getline(".")))
			let s:checkForEnd = 1
		else
			let s:checkForEnd = 0 
		endif
		if getline(".")[col(".")] == g:snip_end_tag
			" We're at a type 1. tag
			normal xx
		elseif (getline(".")[col(".")] == g:snip_elem_delim) && (getline(".")[col(".") + 1] == g:snip_end_tag)
			" We're at a "<:>" tag
			normal xxx
		else
			normal l
		endif
		if s:checkForEnd == 1
			startinsert!
		else
			startinsert
		endif
	else
		" No more matches so we'll jump to the next bit of whitespace
		if match(getline("."),'\W',s:curCurs) == -1
			startinsert!
		elseif match(getline("."),'\W',s:curCurs) < match(getline("."),'$',s:curCurs)
			call search('\W')
			"normal l
			startinsert
		else
			startinsert!
		endif
	endif
endfunction

function! NoChangedVal()
	let s:elem_match = match(s:line, g:snip_elem_delim, s:curCurs)
	if s:elem_match != -1 && s:elem_match < match(s:line, g:snip_end_tag, s:curCurs)
		" We've got a default value.
		" Grab the value to substitute (the default)
		let s:replaceVal = matchstr(s:line, s:search_defVal, s:curCurs)
		" Grab the value to change
		let s:matchVal = strpart(matchstr(s:line, s:search_endVal, match(s:line, g:snip_elem_delim, s:curCurs)),1)
		" Make all the changes
		let s:firstBit = strpart(s:line,0,s:curCurs - 1)
		let s:middleBit = strpart(s:line,s:curCurs,match(s:line,g:snip_elem_delim,s:curCurs)-s:curCurs)
		let s:lastBit = strpart(strpart(s:line,match(s:line,g:snip_end_tag,s:curCurs)),1)
		call setline(line("."),s:firstBit.s:middleBit.s:lastBit)
		while search(g:snip_start_tag.s:matchVal.g:snip_end_tag,"W") > 0
			call setline(line("."),substitute(getline("."), g:snip_start_tag.s:matchVal.g:snip_end_tag, s:replaceVal,"g"))
		endwhile
		call NextHop()
	else
		" We don't have a default value.  This implies that
		" the user just hit Jump.  We'll assume that the
		" default value is the same as the variable name.
		let s:replaceVal = matchstr(s:line, s:search_endVal, s:curCurs)
		let s:matchVal = s:replaceVal
		let s:firstBit = strpart(s:line,0,s:curCurs - 1)
		let s:middleBit = strpart(s:line,s:curCurs,match(s:line,g:snip_end_tag,s:curCurs)-s:curCurs)
		let s:lastBit = strpart(strpart(s:line,match(s:line,g:snip_end_tag,s:curCurs)),1)
		call setline(line("."),s:firstBit.s:middleBit.s:lastBit)
		" Make all the changes
		while search(g:snip_start_tag.s:matchVal.g:snip_end_tag,"W") > 0
			call setline(line("."),substitute(getline("."), g:snip_start_tag.s:matchVal.g:snip_end_tag, s:replaceVal,"g"))
		endwhile
		call NextHop()
	endif
endfunction

function! ChangedVal()
	" We're not by the start of a tag and we're in
	" a tag so we've changed the value.
	let s:startIdx = strridx(strpart(s:line,0,s:curCurs),g:snip_start_tag)
	let s:replaceVal = strpart(strpart(s:line, s:startIdx,s:curCurs - s:startIdx),1)
	if match(s:line, g:snip_elem_delim, s:curCurs) != -1 && (match(s:line, g:snip_elem_delim, s:curCurs) < match(s:line,g:snip_end_tag, s:curCurs))
		" We've got a delimiter tag before the end tag
		let s:matchVal = strpart(matchstr(s:line, s:search_endVal, match(s:line, g:snip_elem_delim, s:curCurs)),1)
		let s:firstBit = strpart(s:line,0,strridx(strpart(s:line,0,s:curCurs),g:snip_start_tag))
		let s:middleBit = strpart(strpart(s:line,strlen(s:firstBit),s:curCurs-strlen(s:firstBit)),1)
		let s:lastBit = strpart(strpart(s:line,match(s:line,g:snip_end_tag,s:curCurs)),1)
		call setline(line("."),s:firstBit.s:middleBit.s:lastBit)
		" Make all the changes
		while search(g:snip_start_tag.s:matchVal.g:snip_end_tag,"W") > 0
			call setline(line("."),substitute(getline("."), g:snip_start_tag.s:matchVal.g:snip_end_tag, s:replaceVal,"g"))
		endwhile
		call NextHop()
	else
		" We don't have a delimiter
		let s:matchVal = matchstr(s:line, s:search_endVal, s:curCurs)
		let s:firstBit = strpart(s:line,0,strridx(strpart(s:line,0,s:curCurs),g:snip_start_tag))
		let s:middleBit = strpart(strpart(s:line,strlen(s:firstBit),s:curCurs-strlen(s:firstBit)),1)
		let s:lastBit = strpart(strpart(s:line,match(s:line,g:snip_end_tag,s:curCurs)),1)
		call setline(line("."),s:firstBit.s:middleBit.s:lastBit)
		" Make all the changes
		while search(g:snip_start_tag.s:matchVal.g:snip_end_tag,"W") > 0
			call setline(line("."),substitute(getline("."), g:snip_start_tag.s:matchVal.g:snip_end_tag, s:replaceVal,"g"))
		endwhile
		call NextHop()
	endif
endfunction

" We need to rewrite this function to reflect the new behaviour. Every jump
" will now delete the markers so we need to allow for the following conditions
" 1. Empty tags e.g. "<>".  When we land inside then we delete the tags.  Make
"    sure to look out for the delimiter i.e. "<:>" should get deleted as well.
" 2. Tag with variable name.  Save the variable name for the next jump.
" 0. Tags with default values.  Save the variable name and pull out the
"    default value, saving it for the next jump.
" 
" Jumper is performed when we want to perform a jump.  If we've landed in a
" 1. style tag then we'll be in free form text and just want to jump to the
" next tag.  If we're in a 2. or 3. style tag then we need to look for whether
" the value has changed and make all the replacements.   If we're in a 3.
" style tag then we need to replace all the occurances with the default value.
" 
function! Jumper()
	" Set up some useful variables
	let s:curCurs = col(".")
	let s:curLine = line(".")
	let s:line = getline(".")
	" Check to see whether we're at the start of a tag.  If we're at the
	" start then we should be assuming that we're in a 3. style tag with a
	" default value.  Otherwise the user will have pressed the jump key
	" without changing the value.
	" First we need to check that we're inside a tag i.e. the previous
	" jump didn't land us in a 1. style tag.
	if g:snip_start_tag != g:snip_end_tag
		" The tags are different so we can check to see whether the
		" end tag comes before a start tag
		let s:endMatch = match(s:line, g:snip_end_tag, s:curCurs)
		let s:startMatch = match(s:line, g:snip_start_tag, s:curCurs)
		if s:endMatch != -1 && ((s:endMatch < s:startMatch) || s:startMatch == -1)
			" End has come before start so we're in a tag.
			if s:line[s:curCurs - 1] == g:snip_start_tag
				call NoChangedVal()
			else
				call ChangedVal()
			endif
		else
			" Right, we're not in a tag so we don't need to do anything.  Set the
			" change value to 'null' and relax
			let s:replaceVal = ""
			call NextHop()
		endif
	else
		" Start and end tags are the same so we need do tag counting to see
		" whether we're in a tag.
		let s:count = 0
		let s:curSkip = s:curCurs
		while match(strpart(s:line,s:curSkip),g:snip_start_tag) != -1 
			if match(strpart(s:line,s:curSkip),g:snip_start_tag) == 0
				let s:curSkip = s:curSkip + 1
			else
				let s:curSkip = s:curSkip + 1 + match(strpart(s:line,s:curSkip),g:snip_start_tag)
			endif
			let s:count = s:count + 1
		endwhile
		if (s:count % 2) == 1
			" Odd number of tags implies we're inside a tag.
			if s:line[s:curCurs - 1] == g:snip_start_tag
				call NoChangedVal()
			else
				call ChangedVal()
			endif
		else
			" We're not inside a tag so we don't need to do anything.  Set the
			" change value to 'null' and relax
			let s:replaceVal = ""
			call NextHop()
		endif
	endif
endfunction

"function! Jumper()
"	let curCurs = col(".")
"	let curLine = line(".")
"	let line = getline(".")
"	if line[col(".") - 1] == "@"
"		call search(g:snip_search_str)
"		"call search("@[^@]*@")
"		let b:var = matchstr(getline("."),g:snip_search_str) 
"		"let b:var = matchstr(getline("."),"@[^@]*@") 
"		let b:var = strpart(b:var,1,strlen(b:var) - 2)
"		normal l
"		startinsert
"	elseif line[col(".")] == "@"
"		execute "normal lxF@x"
"		if search(g:snip_search_str,"W") > 0
"		"if search("@[^@]*@","W") > 0
"			let b:var = matchstr(getline("."),g:snip_search_str) 
"			let b:var = strpart(b:var,1,strlen(b:var) - 2)
"			execute "normal l"
"			startinsert
"		else
"			call cursor(curLine,curCurs)
"			startinsert
"		endif
"	else
"		let b:substr = strpart(line,0,col("."))
"		let b:start = strridx(b:substr,"@") + 1
"		let b:substr = strpart(b:substr,b:start,col(".") - b:start)
"		while search("@".b:var."@","W") > 0
"			execute "s/@".b:var."@/".b:substr."/g"
"		endwhile
"		call cursor(curLine, curCurs)
"		execute "normal ld/@xF@x"
"		if search(g:snip_search_str,"W") > 0
"		"if search("@[^@]*@","W") > 0
"			let b:var = matchstr(getline("."),g:snip_search_str) 
"			let b:var = strpart(b:var,1,strlen(b:var) - 2)
"			execute "normal l"
"			startinsert
"		else
"			startinsert
"		endif
"	endif
"endfunction

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
"Iabbr forin for <elem:element> in <collection>	<element>.<>end<<
"Iabbr forin for @element@ in @collection@	@element@.@@end<<
"Iabbr select select { \|@element@\| @element@.@@ }
