if !exists('loaded_snippet') || &cp
    finish
endif

"Snippet !env #!/usr/bin/env ${1:${TM_SCOPE/(?:source|.*)\\.(\\w+).*/$1/}}
Snippet if if [[ <condition> ]]; then<CR><><CR>fi<>
Snippet elif elif [[ <condition> ]]; then<CR><>
Snippet for for (( <i> = <>; <i> <>; <i><> )); do<CR><><CR>done<>
