if !exists('loaded_snippet') || &cp
    finish
endif

Snippet cat <$MTCategoryDescription$><>
Snippet blog <$MTBlogName$><>
Snippet archive <$MTArchiveFile$><>
Snippet cal <MTCalendarIfEntries<CR><><CR></MTCalendarIfEntries><CR><>
Snippet entry <$MTEntryMore$><>
Snippet entries <MTEntriesHeader><CR><><CR></MTEntriesHeader><CR><>
