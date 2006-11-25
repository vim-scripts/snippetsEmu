if !exists('loaded_snippet') || &cp
    finish
endif

Snippet elseif elseif ( <condition> )<CR>{<CR><><CR>}<CR><>
Snippet do do<CR>{<CR><><CR><CR>} while ( <:D('$a <= 10')> );<CR><>
Snippet reql require_once( '<file>' );<CR><>
Snippet if? $<retVal> = ( <condition> ) ? <a> : <b> ;<CR><>
Snippet php <?php<CR><CR><><CR><CR>?>
Snippet switch switch ( <variable> )<CR>{<CR>case '<value>':<CR><><CR>break;<CR><CR><><CR><CR>default:<CR><><CR>break;<CR>}<CR><>
Snippet class #doc<CR>#classname:<ClassName><CR>#scope:<PUBLIC><CR>#<CR>#/doc<CR><CR>class <ClassName> <extendsAnotherClass><CR>{<CR>#internal variables<CR><CR>#Constructor<CR>function __construct ( <argument>)<CR>{<CR><><CR>}<CR>###<CR><CR>}<CR>###
Snippet incll include_once( '<file>' );<>
Snippet incl include( '${1:file}' );<>
Snippet foreach foreach( $<variable> as $<key> => $<value> )<CR>{<CR><><CR>}<CR><>
Snippet ifelse if ( <condition> )<CR>{<CR><><CR>}<CR>else<CR>{<CR><><CR>}<CR><>
Snippet $_ $_REQUEST['<variable>']<CR><>
Snippet case case '<variable>':<CR><><CR>break;<CR><>
Snippet print print "<string>"<>;<><CR><>
Snippet function <public>function <FunctionName> (<>)<CR>{<CR><><CR>}<CR><>
Snippet if if ( <condition> )<CR>{<CR><><CR>}<CR><>
Snippet else else<CR>{<CR><><CR>}<CR><>
Snippet array $<arrayName> = array( '<>',<> );<>
Snippet -globals $GLOBALS['<variable>']<><something><>;<CR><>
Snippet req require( '<file>' );<CR><>
Snippet for for ( $<i>=<>; $<i> < <>; $<i>++ )<CR>{ <CR><><CR>}<CR><>
Snippet while while ( <> )<CR>{<CR><><CR>}<CR><>
