if !exists('loaded_snippet') || &cp
    finish
endif

Snippet wrap [% WRAPPER <template> %]<CR><><CR>[% END %]<CR><>
Snippet if [% IF <condition> %]<CR><><CR>[% ELSE %]<CR><><CR>[% END %]<CR><>
Snippet unl [% UNLESS <condition> %]<CR><><CR>[% END %]<CR><>
Snippet inc [% INCLUDE <template> %]<CR><>
Snippet for  [% FOR <var> IN <set> %]<CR><><CR>[% END %]<>
