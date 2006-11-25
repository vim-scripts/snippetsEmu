if !exists('loaded_snippet') || &cp
    finish
endif

Snippet <i <index name="<key>_index"><CR><index-column name="<key>" /><CR></index><CR><>
Snippet <t <table name="<name>" <>><CR><><CR></table><CR><>
Snippet <u <unique name="unique_<key>"><CR><unique-column name="<key>" /><CR></unique><CR><>
Snippet <c <column name="<name>" type="<type>" <> /><CR><>
Snippet <p <column name="<id>" type="<integer>" required="true" primaryKey="true" autoincrement="true" /><CR><>
Snippet <f <foreign-key foreignTable="<table>"><CR><reference local="<table>_id" foreign="<id>"/><CR></foreign-key><CR><>
