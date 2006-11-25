if !exists('loaded_snippet') || &cp
    finish
endif

Snippet sub \subsection{<name>}\label{sub:<name:substitute(@z,'.','\l&','g')>}<CR><>
Snippet $$ \[<CR><><CR>\]<CR><>
Snippet ssub \subsubsection{<name>}\label{ssub:<name:substitute(@z,'.','\l&','g')>}<CR><>
Snippet itd \item[<desc>] <>
Snippet sec \section{<name>}\label{sec:<name:substitute(@z,'.','\l&','g')><CR><>
