if !exists('loaded_snippet') || &cp
    finish
endif

function! Count(haystack, needle)
    let counter = 0
    let index = match(a:haystack, a:needle)
    while index > -1
        let counter = counter + 1
        let index = match(a:haystack, a:needle, index+1)
        exec "echom \"index: ". string(index) . "\""
    endwhile
    exec "echom \"found ". string(counter) . " needles\""
    return counter
endfunction

function! DjangoArgList(count)
    " This needs to be Python specific as print expects a
    " tuple and an empty tuple looks like this (,) so we'll need to make a
    " special case for it
    if a:count == 0
        return "(,)"
    else
        return '('.repeat('<>, ', a:count).')'
    endif
endfunction

Snippet {{ {% templatetag openvariable %}<>
Snippet }} {% templatetag closevariable %}<>
Snippet {% {% templatetag openblock %}<>
Snippet %} {% templatetag closeblock %}<>
Snippet now {% now "<>" %}<>
Snippet firstof {% firstof <> %}<>
Snippet ifequal {% ifequal <> <> %}<CR><><CR>{% endifequal %}<CR><>
Snippet ifchanged {% ifchanged %}<>{% endifchanged %}<>
Snippet regroup {% regroup <> by <> as <> %}<>
Snippet extends {% extends "<>" %}<CR><>
Snippet filter {% filter <> %}<CR><><CR><% endfilter %}
Snippet block {% block <> %}<CR><><CR>{% endblock %}<CR><>
Snippet cycle {% cycle <> as <> %}<>
Snippet if {% if <> %}<CR><><CR>{% endif %}<CR><>
Snippet debug {% debug %}<CR><>
Snippet ifnotequal {% ifnotequal <> <> %}<CR><><CR>{% endifnotequal %}<CR><>
Snippet include {% include <> %}<CR><>
Snippet comment {% comment %}<CR><><CR>{% endcomment %}<CR><>
Snippet for {% for <> in <> %}<CR><><CR>{% endfor %}<CR><>
Snippet ssi {% ssi <> <:D('parsed')> %}<>
Snippet model class <>(models.Model):<CR>"""<:D('model description')>"""<CR><> = <><CR><CR>class ADMIN:<CR>pass<CR><CR>def __str__(self):<CR>return "<"%s">" <"%s":DjangoArgList(Count(@z, '%[^%]'))><CR><>
Snippet widthratio {% widthration <:D('this_value')> <:D('max_value')> <:D('100')> %}<>
Snippet load {% load <> %}<CR><>
