if !exists('loaded_snippet') || &cp
    finish
endif

Snippet switch switch<> -- $<var> {<CR><match> {<CR><><CR>}<CR>default<CR>{<>}<CR>}<CR><>
Snippet foreach foreach <var> $<list> {<CR><><CR>}<CR><>
Snippet proc proc <name> {<args>} <CR>{<CR><><CR>}<CR><>
Snippet if if {<condition>} {<CR><><CR>}<CR><>
Snippet for for {<i> {<>} {<>} {<CR><><CR>}<CR><>
Snippet while while {<condition>} {<CR><><CR>}<CR><>
