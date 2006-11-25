if !exists('loaded_snippet') || &cp
    finish
endif

Snippet do do<CR><>end<CR><>
Snippet class class <className><CR><>end<CR><>
Snippet begin begin<CR><><CR>rescue <Exception> => <e><CR><>end<CR><>
Snippet each_with_index0 each_with_index do |<element>, <index>|<CR><element>.<><CR>end<CR><>
Snippet collect collect { |<element>| <element>.<> }<CR><>
Snippet forin for <element> in <collection><CR><element>.<><CR>end<CR><>
Snippet doo do |<object>|<CR><><CR>end<CR><>
Snippet : :<key> => "<value>"<><CR><>
Snippet def def <methodName><CR><><CR>end<CR><>
Snippet case case <object><CR>when <condition><CR><><CR>end<CR><>
Snippet collecto collect do |<element>|<CR><element>.<><CR>end<CR><>
Snippet each each { |<element>| <element>.<> }<CR><>
Snippet each_with_index each_with_index { |<element>, <idx>| <element>.<> }<CR><>
Snippet if if <condition><CR><><CR>end<CR><>
Snippet eacho each do |<element>|<CR><element>.<><CR>end<CR><>
Snippet unless unless <condition><CR><><CR>end<CR><>
Snippet ife if <condition><CR><><CR>else<CR><><CR>end<CR><>
Snippet when when <condition><CR><>
Snippet selecto select do |<element>|<CR><element>.<><CR>end<CR><>
Snippet injecto inject(<object>) do |<injection>, <element>| <CR><><CR>end<CR><>
Snippet reject { |<element>| <element>.<> }<CR><>
Snippet rejecto reject do |<element>| <CR><element>.<><CR>end<CR><>
Snippet inject inject(<object>) { |<injection>, <element>| <> }<CR><>
Snippet select select { |<element>| <element>.<> }<CR><>
