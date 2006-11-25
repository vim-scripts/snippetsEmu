if !exists('loaded_snippet') || &cp
    finish
endif

Snippet Queue Queue.fold <:D('(fun b v ->)')> <base> <q><CR><>
Snippet Nativeint Nativeint.abs <ni><>
Snippet Printexc Printexc.print <fn> <x><>
Snippet Sys Sys.Signal_ignore<>
Snippet Hashtbl Hashtbl.iter <:D('(fun k v -> )')> <h><>
Snippet Array Array.map <:D('(fun a -> )')> <arr><>
Snippet Printf Printf.fprintf <buf> "<format>" <args><>
Snippet Stream Stream.iter <:D('(fun x -> )')> <stream><>
Snippet Buffer Buffer.add_channel <buf> <ic> <len><>
Snippet Int32 Int32.abs <i32><>
Snippet List List.rev_map <:D('(fun x -> )')> <lst><>
Snippet Scanf Scanf.bscaf <sbuf> "<format>" <f><>
Snippet Int64 Int64.abs <i64><>
Snippet Map Map.Make <:D('(Ord : OrderedType)')><>
Snippet String String.iter <:D('(fun c -> )')> <str><>
Snippet Genlex Genlex.make_lexer <"tok_lst"> <"char_stream"><>
Snippet for for <i}> = <> to <> do<CR><><CR>done<CR><>
Snippet Stack Stack.iter <:D('(fun x -> )')> <stk><>
