<{*

$ids: ids of all items to display
$metadata	metadata informatino(array of associative arrays).
    array( 'title'     => title,
           'identifier'  => identifier )
$submit_url URL to go when submit
$maxpage
$page
$pages
$page_no_label
*}>

<script type="text/javascript" src="js/prototype.js">
</script>

<script type="text/javascript">
//<![CDATA[
function showDetail( identifier ){
    $('xoonips_hidden_itemselect_metadata_identifier').value=identifier;
    $('xoonips_item_list_header').action='oaipmh_search.php?action=metadata_detail';
    $('xoonips_item_list_header').submit();
    return false;
}
//]]>
</script>

<h3><{$smarty.const._MD_XOONIPS_ITEM_LISTING_ITEM}></h3>

<{if !empty($error_message) }>
<span style='color:#ff0000;'><{$error_message}></span>
<{else}>

<{if isset( $quick_search_keyword ) }>
<{$smarty.const._MD_XOONIPS_ITEM_SEARCH_KEYWORD}> : <{$quick_search_keyword}>
<{/if}>

<form id="xoonips_item_list_header" action="<{$submit_url}>" method="post">
<input type="hidden" name="op" value="<{$op}>" />
<{if !empty($search_itemtype)}>
<input type='hidden' name='search_itemtype' value='<{$search_itemtype}>' />
<{/if}>
<{if !empty($keyword)}>
<input type='hidden' name='keyword' value='<{$keyword}>' />
<{/if}>
<{include file="db:xoonips_item_list_header.tpl" form_id="xoonips_item_list_header"}>
<{include file="db:xoonips_pagenavi.tpl" maxpage=$maxpage page=$page pages=$pages form_id="xoonips_item_list_header"}>
<{include file="db:xoonips_extra_param.tpl" extra_param=$extra_param}>

<input type='hidden' id='xoonips_page' name='page' value='<{$page}>' />
<input type='hidden' name='search_tab' value='<{$search_tab}>' />

<{if !empty($print_enabled)}>
 <input type='hidden' id='xoonips_print' name='print' value='0' />
 <input type='button'
 value='<{$smarty.const._MD_XOONIPS_ITEM_PRINT_FRIENDLY_BUTTON_LABEL}>'
 onclick='target="_blank"; $("xoonips_print").value=1; submit(); target=""; $("xoonips_print").value=0;' />
<{/if}>

<{* metadata List *}>
<{foreach item=i from=$metadata}>
<table width="100%" border="0" cellspacing="5">
  <tr style="vertical-align: top;">
    <td class="<{cycle values="odd,even" name="cycle2"}>">
     <a href='javascript:void(0)' onclick='return showDetail("<{$i.identifier}>");'><{$i.title}></a>
    </td>
  </tr>
</table>
<{/foreach}>

<input type="hidden" name="search_cache_id" value="<{$search_cache_id}>" />
<input id='xoonips_hidden_itemselect_metadata_identifier' type='hidden' name='identifier' value='' />

<{include file="db:xoonips_pagenavi.tpl" maxpage=$maxpage page=$page form_id="xoonips_item_list_header"}>
<{include file="db:xoonips_extra_param.tpl" extra_param=$extra_param}>
</form>

<{/if}>

<!-- end module search results loop -->
