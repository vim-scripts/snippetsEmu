if !exists('loaded_snippet') || &cp
    finish
endif

Snippet {cycle {cycle values="#SELSTART#<foo>,<bar>#SELEND#" name="default" print=true advance=true delimiter="," assign=varname }<CR><>
Snippet |regex_replace |regex_replace:"<regex>":"<>"<>
Snippet {counter {counter name="#INSERTION#" start=1 skip=1 direction="up" print=true<CR>assign="foo" }<CR><CR>{counter}<CR><>
Snippet {eval {eval var="#SELSTART#{template_format}#SELEND#" assign=varname} <CR><>
"Snippet |date_format |date_format:"${1:strftime() formatting}" <CR><>
Snippet |truncate |truncate:<:D('80')>:<>:<false>
Snippet {if {if <varname><><CR>"<foo>"}<CR><CR>{* $varname can also be a php call *}<CR><CR><><CR><CR>{/if}<CR><>
"Snippet |string_format |string_format:"${1:sprintf formatting}" <CR><>
Snippet {assign {assign var=<> value="<>"}<>
Snippet {foreach {foreach from=<varname> item=i [key=k name=""] }<CR><CR><><CR><CR>{/foreach}<CR><CR><>
Snippet {capture {capture name=#INSERTION#}<CR><CR>#SELECT#<CR><CR>{/capture}<CR><>
Snippet |wordwrap |wordwrap:<:D('80')>:"<>":<>
Snippet |spacify |spacify:"<>"<> 
Snippet |default |default:"<>"<>
Snippet {debug {debug output="#SELSTART#<>#SELEND#" }<>
Snippet |replace |replace:"<needle>":"<>"<>
Snippet {include {include file="<>" [assign=varname foo="bar"] }<>
Snippet |escape |escape:"<>"<>
Snippet {strip {strip}<CR><><CR>{/strip}<>
Snippet {math {math equation="<>" assign=<> <>}<>
Snippet {config_load {config_load file="#INSERTION#" [section="" scope="local|parent|global"] }<>
Snippet |cat  |cat:"<>"<>
Snippet {insert {insert name="insert_<>" [assign=varname script="foo.php" foo="bar"] }<>
Snippet {fetch {fetch file="#SELSTART#http:// or file#SELEND#" assign=varname}<>
Snippet {literal {literal}<CR><CR><><CR><CR>{/literal}<>
Snippet {include_php {include_php file="<>" [once=true]}<>
Snippet |strip |strip:["<>"]<>
