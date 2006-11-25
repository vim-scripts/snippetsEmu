if !exists('loaded_snippet') || &cp
    finish
endif

function! PyInit(text)
    if a:text != "args"
        return ', '.a:text
    else
        return ''
    endif
endfunction

function! PyInitVars(text)
    if a:text != "args"
        let text = substitute(a:text,'=.\{-},','','g')
        let text = substitute(text,'=.\{-}$','','g')
        let text = substitute(text,',','','g')
        let ret = ''
        for Arg in split(text, ' ')
            let ret = ret.'self.'.Arg.' = '.Arg.'\n\t\t'
        endfor
        return ret
    else
        return "pass"
    endif
endfunction

function! Count(haystack, needle)
    let counter = 0
    let index = match(a:haystack, a:needle)
    while index > -1
        let counter = counter + 1
        let index = match(a:haystack, a:needle, index+1)
    endwhile
    return counter
endfunction

function! PyArgList(count)
    " This needs to be Python specific as print expects a
    " tuple and an empty tuple looks like this (,) so we'll need to make a
    " special case for it
    if a:count == 0
        return "()"
    else
        return '('.repeat('<>, ', a:count).')'
    endif
endfunction

Snippet pf print "<s>" % <s:PyArgList(Count(@z, '%[^%]'))><CR><>
Snippet get def get<name>(self): return self._<name><CR><>
Snippet classi class <ClassName> (<object>):<CR><CR>def __init__(self<args:PyInit(@z)>):<CR><args:PyInitVars(@z)><CR><CR><>
Snippet set def set<name>(self, <newValue>):<CR>self._<name>$1 = <newValue><CR><>
Snippet . self.<>
Snippet def def <fname>(<self>):<CR><pass><CR><>
" Contributed by Panos
Snippet ifn if __name__ == '__main__':<CR><>
" Contributed by Kib2
Snippet bc """<description>"""<CR><>
Snippet lc # <linecomment><CR><>
Snippet sbl1 #!/usr/bin/env python<CR># -*- coding: Latin-1 -*-<CR><>
Snippet kfor for <variable> in <ensemble>:<CR><pass><CR><BS><>
Snippet cm <class> = classmethod(<class>)<CR><>
