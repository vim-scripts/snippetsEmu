if !exists('loaded_snippet') || &cp
    finish
endif

function! Count(haystack, needle)
    let counter = 0
    let index = match(a:haystack, a:needle)
    while index > -1
        let counter = counter + 1
        let index = match(a:haystack, a:needle, index+1)
    endwhile
    return counter
endfunction

function! CArgList(count)
    " This returns a list of empty tags to be used as 
    " argument list placeholders for the call to printf
    if a:count == 0
        return ""
    else
        return repeat(', <>', a:count)
    endif
endfunction
	
Snippet do do<CR>{<CR><><CR>} while (<>);
Snippet readfile std::vector<uint8_t> v;<CR>if(FILE* fp = fopen("<filename>", "r"))<CR>{<CR>uint8_t buf[1024];<CR>while(size_t len = fread(buf, 1, sizeof(buf), fp))<CR>v.insert(v.end(), buf, buf + len);<CR>fclose(fp);<CR>}<CR><>
Snippet beginend <v>.begin(), <v>.end()<>
Snippet once #ifndef _<file:substitute(expand('%'),'\(.\)','\u\1','g')>_<CR><CR>#define _<file>_<CR><CR><><CR><CR>#endif /* _<file>_ */<CR><>
Snippet class class <name><CR>{<CR>public:<CR><name> (<arguments>);<CR>virtual ~<name>();<CR><CR>private:<CR><:D('/* data */')><CR>};<CR><>
" TODO This is a good one but I can't quite work out the syntax yet
Snippet printf printf("<"%s">\n" <"%s":CArgList(Count(@z, '%[^%]'))>);<CR><>
Snippet vector std::vector<<char>> v<>;
Snippet struct struct <name><CR>{<CR><:D('/* data */')><CR>};<CR><>
Snippet template template <typename <_InputIter>><CR><>
" TODO this one as well. Wish I knew more C
" Snippet namespace namespace ${1:${TM_FILENAME/(.*?)\\..*/\\L$1/}}\n{\n\t$0\n};<CR><>
Snippet namespace namespace <:substitute(expand('%'),'.','\l&', 'g')><CR>{<CR><><CR>};<CR><>
Snippet map std::map<<key>, <value>> map<>;<CR><>
Snippet mark #if 0<CR><CR><:D('#pragma mark -<CR><CR>'}#pragma mark <><CR><CR>#endif<CR><CR><>
Snippet if if(<>)<CR>{<CR><><CR>}<CR><>
Snippet main int main (int argc, char const* argv[])<CR>{<CR><><CR>return 0;<CR}<CR><>
Snippet Inc #include <<:D('.h')>><CR><>
Snippet inc #include "<>.h"
Snippet for for( <:D('unsigned int')> <i> = <:D('0')>; <i> < <count>; <i> += <:D('1')>)<CR>{<CR><><CR>}<CR><>
