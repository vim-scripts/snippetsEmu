if !exists('loaded_snippet') || &cp
    finish
endif

function! UpFirst()
    return substitute(@z,'.','\u&','')
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

function! ObjCArgList(count)
    " This needs to be Python specific as print expects a
    " tuple and an empty tuple looks like this (,) so we'll need to make a
    " special case for it
    if a:count == 0
        return "<>"
    else
        return '<>'.repeat(', <>', a:count)
    endif
endfunction


Snippet cat @interface <NSObject> (<Category>)<CR><CR>@end<CR><CR><CR>@implementation <NSObject> (<Category>)<CR><CR><><CR><CR>@end<CR><>
Snippet delacc - (id)delegate;<CR><CR>- (void)setDelegate:(id)delegate;<CR><>
Snippet ibo IBOutlet <NSSomeClass> *<someClass>;<CR><>
Snippet dict NSMutableDictionary *<dict> = [NSMutableDictionary dictionary];<CR><>
Snippet Imp #import <<>.h><CR><>
Snippet objc @interface <class> : <NSObject><CR>{<CR>}<CR>@end<CR><CR>@implementation <class><CR>- (id)init<CR>{<CR>self = [super init]; <CR>if (self != nil)<CR>{<CR><><CR>}<CR>return self;<CR>}<CR>@end<CR><>
Snippet imp #import "<>.h"<CR><>
Snippet bez NSBezierPath *<path> = [NSBezierPath bezierPath];<CR><>
Snippet acc - (<"unsigned int">)<thing><CR>{<CR>return <fThing>;<CR>}<CR><CR>- (void)set<thing:UpFirst()>:(<"unsigned int">)new<thing:UpFirst()><CR>{<CR><fThing> = new<thing:UpFirst()>;<CR>}<CR><>
Snippet format [NSString stringWithFormat:@"<>", <>]<>
Snippet focus [self lockFocus];<CR><CR><><CR><CR>[self unlockFocus];<CR><>
Snippet setprefs [[NSUserDefaults standardUserDefaults] setObject:<object> forKey:<key>];<CR><>
Snippet log NSLog(@"%s<s>", <s:ObjCArgList(Count(@z, '%[^%]'))>);<>
Snippet gsave [NSGraphicsContext saveGraphicsState];<CR><><CR>[NSGraphicsContext restoreGraphicsState];<CR><>
Snippet forarray for(unsigned int index = 0; index < [<array> count]; index += 1)<CR>{<CR><id>object = [<array> objectAtIndex:index];<CR><><CR>}<>
Snippet classi @interface <ClassName> : <NSObject><CR><CR>{<><CR><CR>}<CR><CR><><CR><CR>@end<CR><>
Snippet array NSMutableArray *<array> = [NSMutableArray array];<>
Snippet getprefs [[NSUserDefaults standardUserDefaults] objectForKey:<key>];<>
Snippet cati @interface <NSObject> (<Category>)<CR><CR><><CR><CR>@end<CR><>
