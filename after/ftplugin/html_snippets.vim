if !exists('loaded_snippet') || &cp
    finish
endif

function! Onload()
    return 'onload="<>"'
endfunction

function! Id()
    return ' id="<>"'
endfunction

function! Cellspacing()
    return ' cellspacing="<:D('5')>"'
endfunction

function! FileNoExt()
    return substitute(expand('%'), '\(.*\)\..*$', '\1','')
endfunction

function! Target()
    return ' target="<>"'
endfunction

Snippet doctype <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN"<CR><Tab>"http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd"><CR><>
Snippet head <head><CR><Tab><meta http-equiv="Content-type" content="text/html; charset=utf-8" /><CR><Tab><title><:substitute(expand('%'),'\(.*\)\..*$','\1','')></title><CR><Tab><><CR></head><CR><>
Snippet script <script type="text/javascript" language="javascript" charset="utf-8"><CR>// <![CDATA[<CR><Tab><><CR>// ]]><CR></script><CR><>
Snippet title <title><:substitute(expand('%'),'\(.*\)\..*$','\1','')></title>
Snippet body <body id="<:FileNoExt()>" <:Onload()><CR><><CR></body><CR><>
Snippet scriptsrc <script src="<>" type="text/javascript" language="<:D('javascript')>" charset="<:D('utf-8')>"></script><CR><>
Snippet textarea <textarea name="<:D('Name')>" rows="<:D('8')>" cols="<:D'(40')>"><></textarea><CR><>
Snippet meta <meta name="<:D('name')>" content="<:D('content')>" /><CR><>
Snippet movie <object width="<>" height="<>"<CR>classid="clsid:02BF25D5-8C17-4B23-BC80-D3488ABDDC6B"<CR>codebase="http://www.apple.com/qtactivex/qtplugin.cab"><CR><Tab><param name="src"<CR>value="<>" /><CR><Tab><param name="controller" value="<>" /><CR><param name="autoplay" value="<>" /><CR><Tab><embed src="<:D('movie.mov')>"<CR><Tab>width="<:D('320')>" height="<D('240')>"<CR><Tab>controller="<:D('true')>" autoplay="<:D('true')>"<CR><Tab><Tab>scale="tofit" cache="true"<CR><Tab><Tab>pluginspage="http://www.apple.com/quicktime/download/"<CR><Tab>/><CR></object><CR><>
Snippet div <div<:Id()>><CR><><CR></div><CR><>
Snippet mailto <a href="mailto:<>?subject=<:D('feedback')>"><:D('email me')></a><>
Snippet table <table border="<:D('0')>"<:Cellspacing()> cellpadding="<:D('5')>"><CR><Tab><tr><th><:D('Header')></th></tr><CR><Tab><tr><td><></td></tr><CR></table>
Snippet link <link rel="<:D('stylesheet')>" href="<:D('/css/master.css')>" type="text/css" media="<:D('screen')>" title="<>" charset="<:D('utf-8')>" />
Snippet form <form action="<:D(FileNoExt().'_submit')>" method="<:D('get')>"><CR><Tab><><CR><CR><Tab><p><input type="submit" value="Continue &rarr;" /></p><CR></form><CR><>
Snippet ref <a href="<>"><></a><>
Snippet h1 <h1 id="<>"><></h1><>
Snippet input <input type="<:D('text/submit/hidden/button')>" name="<>" value="<>" <>/><>
Snippet style <style type="text/css" media="screen"><CR>/* <![CDATA[ */<CR><Tab><><CR>/* ]]> */<CR></style><CR><>
Snippet base <base href="<>"<:Target()> /><>
