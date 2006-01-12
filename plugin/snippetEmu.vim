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
" Iabbr forin for @element@ in @collection@<CR>@element@.@@<CR>end
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
" Future Features:
"
" Commands in tags.  The first named tag should be able to define a default
" value.  Further tags with the same name should be allowed to have a command
" instead of a default tag which would then be executed with 'execute'.  The
" idea is to allow for TextMate style functionality e.g. getter/setter snippets
" for Obj-C.  Added in 0.3
" 
" Known Bugs:
"
" If the abbreviation starts with a tag and is inserted at the start of the line
" then the cursor will not be placed in the correct tag.
"
" FIXED Empty tag replacement.  Changing an empty tag will change all remaining
" empty tags
"
" FIXED Short variable names.  Having a single character in the tags will mess up
" the insert point.
"
" FIXED Autoindentation breaks and too much whitespace can be swallowed.
" Caused by using 'i' instead of 'a' in the redefined command.

if exists('loaded_snippet') || &cp
	finish
endif

let loaded_snippet=1

" {{{ Set up variables
if !exists("g:snip_start_tag")
	let g:snip_start_tag = "<"
endif

if !exists("g:snip_end_tag")
	let g:snip_end_tag = ">"
endif

if !exists("g:snip_elem_delim")
	let g:snip_elem_delim = ":"
endif

let s:just_expanded = 0

" }}}
" {{{ Map Jumper to the default key if not set already
if ( !hasmapto( '<Plug>Jumper', 'i' ) )
   imap <unique> <S-Del> <Plug>Jumper
endif
imap <silent> <script> <Plug>Jumper <ESC>:call Jumper()<CR>

" }}}
" {{{ Set up the search strings based on the start and end tags
" A tag is now defined to be non-whitespace characters surrounded by start and
" end tags.  A tag cannot contain a second start tag before the end tag.
" Due to the way in which character classes are defined in Vim we cannot
" easily exclude whitespace but we give it a good go.
"let s:search_str = g:snip_start_tag."[^<CR>	 ".g:snip_start_tag.g:snip_end_tag."]*".g:snip_end_tag
let s:search_str = g:snip_start_tag."[^\<CR>\<TAB> ".g:snip_start_tag.g:snip_end_tag."]*".g:snip_end_tag
let s:search_defVal = "[^".g:snip_elem_delim."]*"
let s:search_endVal = "[^".g:snip_end_tag."]*"
" }}}
" {{{ SetCom(text) - Set command function
function! SetCom(text)
	if match(a:text,"<buffer>") == 0
		return "iabbr <buffer> ".substitute(strpart(a:text,stridx(a:text,">")+2)," "," <ESC>:call SetPos()<CR>a","")."<ESC>:call NextHop()<CR><C-R>=Eatchar('\\s')<CR>"
	else
		return "iabbr ".substitute(a:text," "," <ESC>:call SetPos()<CR>a","")."<ESC>:call NextHop()<CR><C-R>=Eatchar('\\s')<CR>"
	endif
endfunction
" }}}
" {{{ SetPos() - Store the current cursor position
" This function also now sets up the search strings so that autocommands can be
" used to defined different tag delimiters for different filetypes
function! SetPos()
  let b:curCurs = col(".")
  let b:curLine = line(".")
  let s:curCurs = col(".")
  let s:curLine = line(".")
  let s:search_str = g:snip_start_tag."[^	 ".g:snip_start_tag.g:snip_end_tag."]*".g:snip_end_tag
  let s:search_defVal = "[^".g:snip_elem_delim."]*"
  let s:search_endVal = "[^".g:snip_end_tag."]*"
  let s:just_expanded = 1
endfunction
" }}}
" {{{ MovePos() - Move the cursor
function! MovePos()
   "let s:search_str = g:snip_start_tag."[^	 ".g:snip_start_tag.g:snip_end_tag."]*".g:snip_end_tag
	call cursor(b:curLine, 1)
	" Check to see if we've just added a tag at the start of the line.  If not
	" then search for the next tag.
	if match(getline("."),s:search_str) != 0
		call search(s:search_str)
	endif
	if getline(".")[col(".")] == g:snip_end_tag
		" We're at a type 1. tag
		normal xx
	elseif getline(".")[col(".")] == g:snip_elem_delim && getline(".")[col(".") + 1] == g:snip_end_tag
		" We're at a "<:>" tag
		normal xxx
	endif
	normal l
	startinsert
endfunction
" }}}
" {{{ SetVar() - Set the current tag value - NOT USED ANYWHERE
" Will be used to replace all other similar tags
function! SetVar()
      "let s:search_str = g:snip_start_tag."[^	 ".g:snip_start_tag.g:snip_end_tag."]*".g:snip_end_tag
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
" }}}
" {{{ NextHop() - Jump to the next tag if one is available
function! NextHop()
   "let s:search_str = g:snip_start_tag."[^	 ".g:snip_start_tag.g:snip_end_tag."]*".g:snip_end_tag
	"call cursor(s:curLine, s:curCurs)
   if s:just_expanded == 1
     call cursor(s:curLine, 1)
     let s:just_expanded = 0
   else
     call cursor(s:curLine, s:curCurs)
   endif
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
" }}}
" {{{ MakeChanges() - Search the document making all the changes required
" This function have been factor out to allow the addition of commands in tags

function! MakeChanges()
		" Make all the changes
      " Change all the tags with the same name and no commands defined
		while search(g:snip_start_tag.s:matchVal.g:snip_end_tag,"W") > 0
			call setline(line("."),substitute(getline("."), g:snip_start_tag.s:matchVal.g:snip_end_tag, s:replaceVal,"g"))
		endwhile
      " Change all the tags with the same name and a command defined.
      " I.e. start tag, tag name (matchVal), element delimiter, characters not
      " whitespace and then end tag
      " First jump back to where we were as the search doesn't wrap (get an
      " infinite loop otherwise)
     if s:just_expanded == 1
       call cursor(s:curLine, 1)
       let s:just_expanded = 0
     else
       call cursor(s:curLine, s:curCurs)
     endif
      while search(g:snip_start_tag.s:matchVal.g:snip_elem_delim,"W") > 0
        " Grab the command
        "let s:snip_command = matchstr(getline("."),g:snip_elem_delim.".*".g:snip_end_tag, 0)
        let s:snip_command = matchstr(getline("."),g:snip_elem_delim.".\\{-}".g:snip_end_tag, 0)
        " Escape backslashes for the matching.  Not sure what other escaping is
        " needed here
        let s:snip_temp = substitute(s:snip_command, "\\", "\\\\\\\\","g")
        " Replace the value
		  call setline(line("."),substitute(getline("."), g:snip_start_tag.s:matchVal.s:snip_temp, s:replaceVal, "g"))
        " Trim and execute the command
        let s:snip_command = strpart(s:snip_command,1, strlen(s:snip_command)-2)
        execute s:snip_command
		endwhile
endfunction

" }}}
" {{{ NoChangedVal() - Tag not changed
function! NoChangedVal()
   "let s:search_defVal = "[^".g:snip_elem_delim."]*"
   "let s:search_endVal = "[^".g:snip_end_tag."]*"
	let s:elem_match = match(s:line, g:snip_elem_delim, s:curCurs)
	if s:elem_match != -1 && s:elem_match < match(s:line, g:snip_end_tag, s:curCurs)
     " We've got a default value (g:snip_elem_delim is present before the end
     " tag)
     " We're assuming that the user is not editing a tag which has a command in
     " it, as this would not really make sense... Might be a bad assumption
		" Grab the value to substitute (the default)
		let s:replaceVal = matchstr(s:line, s:search_defVal, s:curCurs)
		" Grab the value to change
		let s:matchVal = strpart(matchstr(s:line, s:search_endVal, match(s:line, g:snip_elem_delim, s:curCurs)),1)
		let s:firstBit = strpart(s:line,0,s:curCurs - 1)
		let s:middleBit = strpart(s:line,s:curCurs,match(s:line,g:snip_elem_delim,s:curCurs)-s:curCurs)
		let s:lastBit = strpart(strpart(s:line,match(s:line,g:snip_end_tag,s:curCurs)),1)
		call setline(line("."),s:firstBit.s:middleBit.s:lastBit)

      call MakeChanges()
      " {{{ Replaced the following with the above function call
      " Make all the changes
		"while search(g:snip_start_tag.s:matchVal.g:snip_end_tag,"W") > 0
	   "		call setline(line("."),substitute(getline("."), g:snip_start_tag.s:matchVal.g:snip_end_tag, s:replaceVal,"g"))
		"endwhile
      " }}}
		
      
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

      if s:matchVal != ""
        call MakeChanges()
      endif
      " {{{ Replaced the following with the above function call
		" Make all the changes
		"if s:matchVal != ""
		"	while search(g:snip_start_tag.s:matchVal.g:snip_end_tag,"W") > 0
		"		call setline(line("."),substitute(getline("."), g:snip_start_tag.s:matchVal.g:snip_end_tag, s:replaceVal,"g"))
		"	endwhile
		"endif
      " }}}
		call NextHop()
	endif
endfunction
" }}}
" {{{ ChangedVal() - The user changed the value in the tag
function! ChangedVal()
   "let s:search_endVal = "[^".g:snip_end_tag."]*"
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
      
      call MakeChanges()
      
      " {{{ Replaced the following with the above function call
		" Make all the changes
		"while search(g:snip_start_tag.s:matchVal.g:snip_end_tag,"W") > 0
		"	call setline(line("."),substitute(getline("."), g:snip_start_tag.s:matchVal.g:snip_end_tag, s:replaceVal,"g"))
		"endwhile
      " }}}
		call NextHop()
	else
		" We don't have a delimiter
		let s:matchVal = matchstr(s:line, s:search_endVal, s:curCurs)
		let s:firstBit = strpart(s:line,0,strridx(strpart(s:line,0,s:curCurs),g:snip_start_tag))
		let s:middleBit = strpart(strpart(s:line,strlen(s:firstBit),s:curCurs-strlen(s:firstBit)),1)
		let s:lastBit = strpart(strpart(s:line,match(s:line,g:snip_end_tag,s:curCurs)),1)
		call setline(line("."),s:firstBit.s:middleBit.s:lastBit)
		" Make all the changes
		if s:matchVal != ""
        call MakeChanges()
      " {{{ Replaced the following with the above function call
		"	while search(g:snip_start_tag.s:matchVal.g:snip_end_tag,"W") > 0
		"		call setline(line("."),substitute(getline("."), g:snip_start_tag.s:matchVal.g:snip_end_tag, s:replaceVal,"g"))
		"	endwhile
      "	}}}
		endif
		call NextHop()
	endif
endfunction
" }}}
" {{{ Jumper()
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
   
   " Custom mod for user who wanted to use TAB for tabs and Jumper
   " if substitute(strpart(getline("."),1, col(".")), "\<TAB>", '', 'g') != ''
   "if substitute(getline("."), "\<TAB>", '', 'g') != ''
  
	if g:snip_start_tag != g:snip_end_tag
		" The tags are different so we can check to see whether the
		" end tag comes before a start tag
		let s:endMatch = match(s:line, g:snip_end_tag, s:curCurs)
		let s:startMatch = match(s:line, g:snip_start_tag, s:curCurs)
		let s:whiteSpace = match(s:line, '\s', s:curCurs)

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
			" call confirm("Not in Tag") " DEBUG
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
   " Rest of custom TAB for tab modification
" else
"    call setline(line("."), getline(".")."\<TAB>")	
"    startinsert!
			"call setline(line("."),strpart(getline("."),1,col("."))."\<TAB>".strpart(getline("."), col(".")))
         "normal a
         "startinsert
			"let s:replaceVal = ""
			"call NextHop()
"	endif
endfunction
" }}}
" {{{ Set up the 'Iabbr' command.
command! -nargs=+ Iabbr execute SetCom(<q-args>)

" {{{ Utility functions
" The following two functions are from Benji Fisher's foo.vim - a very helpful file
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
" }}}
" Abbreviations are set up as usual but using the Iabbr command rather
" than iabbr.  Formatting needs to be done as usual, hence the '<<'s and
" similar.  Not sure how well @ works as a delimiter but it can be changed
" BEST PRACTICE RECOMMENDATION: Store your abbeviation definitions in
" '.vim/after/plugin/' so they will get sourced once the plugin has been loaded
" Examples:
"Iabbr forin for <elem:element> in <collection><CR>	<element>.<><CR>end<ESC><<
"Iabbr forin for @element@ in @collection@<CR>	@element@.@@<CR>end<ESC><<
"Iabbr select select { \|@element@\| @element@.@@ }
" }}}
" vim: set fenc=utf-8 tw=80 sw=2 sts=2 et foldmethod=marker :
