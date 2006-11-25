if !exists('loaded_snippet') || &cp
    finish
endif

Snippet mrnt rename_table "<oldTableName>", "<newTableName>"<>
Snippet rfu render :file => "<filepath>", :use_full_path => <false><>
Snippet rns render :nothing => <true>, :status => <:D('401')><>
Snippet ri render :inline => "<:D("<%= 'hello' %>")>"<>
Snippet rt render :text => "<>"<>
Snippet mcc t.column "<title>", :<string><>
Snippet rpl render :partial => "<item>", :locals => { :<name> => "<value>"<> }<>
Snippet rea redirect_to :action => "<index>"<>
Snippet rtlt render :text => "<>", :layout => <true><>
Snippet ft <%= form_tag :action => "<update>" %><>
Snippet forin <% for <item> in <:D('@items')> %><CR><%= <item>.<name> %><CR><% end %><CR><>
Snippet lia <%= link_to "<>", :action => "<index>" %><>
Snippet rl render :layout => "<layoutname>"<>
Snippet ra render :action => "<action>"<>
Snippet mrnc rename_column "<table>", "<oldColumnName>", "<newColumnName>"<>
Snippet mac add_column "<table>", "<column>", :<string><>
Snippet rpc render :partial => "<item>", :collection => <items><>
Snippet rec redirect_to :controller => "<items>"<>
Snippet rn render :nothing => <true><>
Snippet lic <%= link_to "<>", :controller => "<>" %><>
Snippet rpo render :partial => "<item>", :object => <object><>
Snippet rts render :text => "<>", :status => <:D('401')><>
Snippet rcea render_component :action => "<index>"<>
Snippet recai redirect_to :controller => "<items>", :action => "<show>", :id => <:D('@item')><>
Snippet mcdt create_table "<table>" do |t|<CR><><CR>end<CR><><CR><>
Snippet ral render :action => "<action>", :layout => "<layoutname>"<>
Snippet rit render :inline => "<>", :type => <:D(':rxml')><>
Snippet rceca render_component :controller => "<items>", :action => "<index>"<>
Snippet licai <%= link_to "<>", :controller => "<items>", :action => "<edit>", :id => <:D('@item')> %><>
Snippet verify verify :only => [:<>], :method => :post, :render => {:status => 500, :text => "use HTTP-POST"}<>
Snippet mdt drop_table "<table>"<>
Snippet rp render :partial => "<item>"<>
Snippet rcec render_component :controller => "<items>"<>
Snippet mrc remove_column "<table>", "<column>"<>
Snippet mct create_table "<table>" do |t|<CR><><CR>end<CR><>
Snippet flash flash[:<notice>] = "<>"<>
Snippet rf render :file => "<filepath>"<>
Snippet lica <%= link_to "<>", :controller => "<items>", :action => "<index>" %><>
Snippet liai <%= link_to "<>", :action => "<edit>", :id => <:D('@item')> %><>
Snippet reai redirect_to :action => "<show>", :id => <:D('@item')><>
Snippet logi logger.info "<>"<>
Snippet marc add_column "<table>", "<column>", :<string><CR><CR><><CR><>
Snippet rps render :partial => "<item>", :status => <:D('500')><>
Snippet ril render :inline => "<>", :locals => { <:D(':name')> => "<value>"<> }<>
Snippet rtl render :text => "<>", :layout => "<>"<>
Snippet reca redirect_to :controller => "<items>", :action => "<list>"<>
