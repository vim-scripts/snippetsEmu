if !exists('loaded_snippet') || &cp
    finish
endif

function! MyX()
    return 'my <x> '
endfunction

Snippet sub sub <functionName> {<CR><><CR>}<CR><>
Snippet class package <ClassName>;<CR><CR><:D('use base qw(')><ParentClass>);<CR><CR>}sub new {<CR>my \$class = shift;<CR>\$class = ref \$class if ref \$class;<CR>my $self = bless {}, \$class;<CR>\$self;<CR>}<CR><CR>1;<CR><>
Snippet xfore <expression> foreach @<array>;<>
Snippet xwhile <expression> while <condition>;<>
Snippet xunless <expression> unless <condition>;<>
Snippet slurp my $<var>;<CR><CR>{ local $/ = undef; local *FILE; open FILE, "<<file>"; $<var> = <FILE>; close FILE }<>
Snippet if if (<>) {<CR><><CR>}<CR><>
Snippet unless unless (<>) {<CR><2><CR>}<CR><>
Snippet ifee if (<>) {<CR><2><CR>} elsif (<>) {<CR><><CR>} else {<CR><>}<CR>}<CR><>
Snippet ife if (<>) {<CR><><CR>} else {<CR><><CR>}<CR><>
Snippet for for (my \$<var> = 0; \$<var> < <expression>; \$<var>++) {<CR><><CR>}<CR><>
Snippet fore foreach <:MyX()>(@<array>) {<CR><><CR>}<CR><>
Snippet eval eval {<CR><><CR>};<CR>if ($@) {<CR><><CR>}<CR><>
Snippet while while (<>) {<CR><><CR>}<CR><>
Snippet xif <expression> if <condition>;<>
