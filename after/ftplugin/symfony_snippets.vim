if !exists('loaded_snippet') || &cp
    finish
endif

Snippet image_tag image_tag('<imageName>'<>)<>
Snippet get public function get<> ()<CR>{<CR>return $this-><>;<CR>}<CR><CR><>
Snippet link_to link_to('<linkName>', '<moduleName>/<actionName><>')<>
Snippet sexecute public function execute<Action>()<CR>{<CR><><CR>}<CR><>
Snippet set public function set<> ($<>)<CR>{<CR>$this-><> = <>;<CR>}<CR><CR><>
Snippet execute /**<CR>* <className><CR>*<CR>*/<CR>public function execute<Action>()<CR>{<CR><><CR>}<CR><>
Snippet tforeach <?php foreach ($<variable> as $<key><>): ?><CR><><CR><?php endforeach ?><CR><>
Snippet getparam $this->getRequestParameter('<id>')<>
Snippet div <div<>><CR><><CR></div><>
Snippet tif <?php if (<condition>): ?><CR><><CR><?php endif ?><CR><>
Snippet setget public function set<var> (<arg>)<CR>{<CR>$this-><arg> = <arg>;<CR>}<CR><CR>public function get<var> ()<CR>{<CR>return $this-><var>;<CR>}<CR><CR><>
Snippet echo <?php echo <> ?><>
Snippet tfor <?php for($<i> = <>; $<i> <= <>; $<i>++): ?><CR><><CR><?php endfor ?><CR><>
