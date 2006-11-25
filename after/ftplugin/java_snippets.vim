if !exists('loaded_snippet') || &cp
    finish
endif

function! UpFirst()
    return substitute(@z,'.','\u&','')
endfunction

function! JavaTestFileName(type)
    let filepath = expand('%:p')
    let filepath = substitute(filepath, '/','.','g')
    let filepath = substitute(filepath, '^.\(:\\\)\?','','')
    let filepath = substitute(filepath, '\','.','g')
    let filepath = substitute(filepath, ' ','','g')
    let filepath = substitute(filepath, '.*test.','','')
    if a:type == 1
        let filepath = substitute(filepath, '.[A-Za-z]*.java','','g')
    elseif a:type == 2
        let filepath = substitute(filepath, 'Tests.java','','')
    elseif a:type == 3
        let filepath = substitute(filepath, '.*\.\([A-Za-z]*\).java','\1','g')
    elseif a:type == 4
        let filepath = substitute(filepath, 'Tests.java','','')
        let filepath = substitute(filepath, '.*\.\([A-Za-z]*\).java','\1','g')
    elseif a:type == 5
        let filepath = substitute(filepath, 'Tests.java','','')
        let filepath = substitute(filepath, '.*\.\([A-Za-z]*\).java','\1','g')
        let filepath = substitute(filepath, '.','\l&','')
    endif

    return filepath
endfunction

Snippet method // {{{ <method><CR>/**<CR> * <><CR> */<CR>public <return> <method>() {<CR><>}<CR>// }}}<CR><>
Snippet jps private static final <string> <> = "<>";<CR><>
Snippet jtc try {<CR><><CR>} catch (<> e) {<CR><><CR>} finally {<CR><><CR>}<CR><>
Snippet jlog /** Logger for this class and subclasses. */<CR><CR>protected final Log log = LogFactory.getLog(getClass());<CR><>
Snippet jpv private <string> <>;<CR><CR><>
Snippet bean // {{{ set<fieldName:UpFirst()><CR>/**<CR> * Setter for <fieldName>.<CR> * @param new<fieldName:UpFirst()> new value for <fieldName><CR> */<CR>public void set<fieldName:UpFirst()>(<String> new<fieldName:UpFirst()>) {<CR><fieldName> = new<fieldName:UpFirst()>;<CR>}<CR>// }}}<CR><CR>// {{{ get<fieldName:UpFirst()><CR>/**<CR> * Getter for <fieldName>.<CR> * @return <fieldName> */<CR>public <String> get<fieldName:UpFirst()>() {<CR>return <fieldName>;<CR>}<CR>// }}}<CR><>
Snippet jwh while (<>) { // <><CR><CR><><CR><CR>}<CR><>
Snippet sout System.out.println("<>");<>
" The following snippet is quite complicated and I'm not quite sure what the
" syntax is supposed to be.
"Snippet jtest package <j:JavaTestFileName(1)><CR><CR>import junit.framework.TestCase;<CR>import <j:JavaTestFileName(2)>;<CR><CR>/**<CR> * <j:JavaTestFileName(3)><CR> *<CR> * @author <><CR> * @since <><CR> */<CR>public class <j:JavaTestFileName(3)> extends TestCase {<CR><CR>private <j:JavaTestFileName(4)> <j:JavaTestFileName(5)>;<CR><CR>public <j:JavaTestFileName(4)> get<j:JavaTestFileName(4)>() { return this.<j:JavaTestFileName(5)>; }<CR>public void set<j:JavaTestFileName(4)>(<j:JavaTestFileName(4)> <j:JavaTestFileName(5)>) { this.<j:JavaTestFileName(5)> = <j:JavaTestFileName(5)>; }<CR><CR>public void test<>() {<CR><><CR>}<CR>}<CR><>
Snippet jif if (<>) { // <><CR><><CR>}<CR><>
Snippet jelse if (<>) { // <><CR><CR><><CR><CR>} else { // <><CR><><CR>}<CR><>
Snippet jpm /**<CR> * <><CR> *<CR> * @param <> <><CR> * <:D('@return')> <><CR> */<CR>private <void> <>(<String> <>) {<CR><CR><><CR><CR>}<CR><>
Snippet main public main static void main(String[] ars) {<CR><"System.exit(0)">;<CR>}<CR><>
Snippet jpum /**<CR> * <><CR> *<CR> * @param <> <><CR> *<:D('@return')> <><CR> */<CR>public <void> <>(<String> <>) {<CR><CR><><CR><CR>}<CR><>
Snippet jcout <c:out value="${<>}" /><>
