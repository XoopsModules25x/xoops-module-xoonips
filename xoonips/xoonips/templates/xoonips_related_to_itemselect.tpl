<{*

open another window to search items in function 'related to' 

$http_vars:         associate array in parameters that send to the following page
$i:                 general
$ids:               ids of all item to display
$item_count_select
$item_htmls:        information of items(association array)
                    array( 'html'     => (summary of item in HTML),
                           'item_id'  => id of item )
$itemcount:         number of items to display a page
$jumpto_url
$maxpage
$order_by_select
$page
$page_no_label
$pages
$search_var[]:      array of parameter name that send in submit
$selected
$export_enabled:    when items in this page can export, this parameter is defined.
*}>

<script type="text/javascript" src="js/prototype.js">
</script>

<h3><{$smarty.const._MD_XOONIPS_ITEM_LISTING_ITEM}></h3>

<{if !empty($error_message) }>
<span style='color:#ff0000;'><{$error_message}></span>
<{else}>

<form id="xoonips_related_to_itemselectform" name="xoonips_related_to_itemselectform" action="<{$jumpto_url}>" method="post">
<input id='xoonips_page' type='hidden' name='page' value='1' />

<input class="formButton" type='button' value='<{$smarty.const._MD_XOONIPS_ITEM_RELATED_TO_CLOSE_LABEL}>' onclick="window.close();" />

<{include file="db:xoonips_item_list_header.tpl" form_id="xoonips_related_to_itemselectform"}>
<{include file="db:xoonips_pagenavi.tpl" maxpage=$maxpage page=$page pages=$pages form_id="xoonips_related_to_itemselectform"}>

<{if !empty( $item_htmls )}>
<table width="100%" border="0" cellspacing="3">
 <tr style='vertical-align:middle; text-align:center;'>
  <th><{$smarty.const._MD_XOONIPS_ITEM_RELATED_TO_ITEM_ID}></th>
  <th><{$smarty.const._MD_XOONIPS_ITEM_RELATED_TO_ITEM_SUMMARY}></th>
 </tr>
<{foreach item=i from=$item_htmls}>
  <tr valign="top">
    <td align='center' style='vertical-align:middle; text-align:center;' class="<{cycle values="odd,even" name="cycle1"}>">
     <{$i.item_id}>
    </td>
    <td class="<{cycle values="odd,even" name="cycle2"}>">
     <{$i.html}>
    </td>
  </tr>
<{/foreach}>
</table>

<{include file="db:xoonips_pagenavi.tpl" maxpage=$maxpage page=$page form_id="xoonips_related_to_itemselectform"}>
<{/if}>

<br>

<{/if}><{* error_message *}>

<{foreach key=k item=v from=$http_vars}>
 <input type="hidden" name="<{$k}>" value="<{$v}>" />
<{/foreach}>
<{foreach item=id from=$selected}>
 <input type="hidden" name="selected[]" value="<{$id}>" />
<{/foreach}>
<{foreach item=id from=$initially_selected}>
 <input type="hidden" name="initially_selected[]" value="<{$id}>" />
<{/foreach}>
<{foreach item=i from=$search_var}>
 <input type="hidden" name="search_var[]" value="<{$i}>" />
<{/foreach}>
 <input type="hidden" name="jumpto_url" value="<{$jumpto_url}>" />

<input type="hidden" name="index_id" value="<{$index_id}>" />
<input type="hidden" name="op" value="<{$op}>" />
<{if $checkbox=='on'}>
 <input class="formButton" type="submit"
 value="<{$smarty.const._MD_XOONIPS_ITEM_SELECT_BUTTON_LABEL}>" onclick="op.value='add_selected_item'" />
<{/if}>
<input type="hidden" name="checkbox" value="<{$checkbox}>" />
<input type="hidden" name="add_to_index_id" value="<{$add_to_index_id}>" />
<input type="hidden" name="print" value="" />
</form>

<!-- end module search results loop -->
