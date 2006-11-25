if !exists('loaded_snippet') || &cp
    finish
endif

Snippet do do: [| :<each>| <>]<CR><>
Snippet proto define: #<NewName> &parents: {<parents>} &slots: {<slotSpecs>}.<CR><>
Snippet ifte <condition> ifTrue: [<>:then] ifFalse: [<>:else]<CR><>
Snippet collect collect: [| :<each>| <>]<CR><>
Snippet if <condition> ifTrue: [<>:then]<>
Snippet until [<condition>] whileFalse: [<>:body]<>
Snippet reject reject: [| :<each>| <>]<CR><>
Snippet dowith doWithIndex: [| :<each> :<index> | <>]<CR><>
Snippet select select: [| :<each>| <>]<>
Snippet while [<condition>] whileTrue: [<>:body]<>
Snippet inject inject: <object> [| :<injection>, :<each>| <>]<>
