<{*

$http_vars: association array of parameters to send to next page
$ids: ids of all items to display
$item_htmls: information of items(association array).
    array( 'selected' => (1:checked 0:not checked),
           'html'     => (summary of item in HTML),
           'item_id'  => id of item )
$metadata	metadata informatino(array of associative arrays).
    array( 'title'     => title,
           'identifier'  => identifier )
$submit_url URL to go when submit
$maxpage
$page
$page_no_label
$search_var[]:   array of parameter names that send in submit.
$selected
$search_tabs tabname of [item] [metadata] and [file] array('label'=>tab label,'count'=>nuber of result in the tab)
$search_tab 
$url_for_get:    url for displaying this page directly
$export_enabled: when items in this page can export, this parameter is defined.
$print_enabled: if defined, print button is visible.
*}>

<script type="text/javascript" src="js/prototype.js">
</script>
<script type="text/javascript">
//<![CDATA[

function showDetail( identifier ){
    $('xoonips_hidden_itemselect_metadata_identifier').value=identifier;
    $('xoonips_itemselect').action='oaipmh_search.php?action=metadata_detail';
    $('xoonips_itemselect').submit();
    return false;
}

function submit_search_tab( str )
{
  var form = document.getElementById( 'xoonips_itemselect' );
  form.print.value='';
  form.target='';
  form.search_tab.value = str;
  form.action = '';
  form.submit();
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

<form id="xoonips_itemselect" action="<{$submit_url}>" method="post">
<input type='hidden' name='op' value='<{$op}>' />
<{if !empty($search_itemtype)}>
<input type='hidden' name='search_itemtype' value='<{$search_itemtype}>' />
<{/if}>
<{if !empty($keyword)}>
<input type='hidden' name='keyword' value='<{$keyword}>' />
<{/if}>
<{include file="db:xoonips_item_list_header.tpl" form_id="xoonips_itemselect"}>
<{include file="db:xoonips_pagenavi.tpl" maxpage=$maxpage page=$page pages=$pages form_id="xoonips_itemselect"}>
<{include file="db:xoonips_extra_param.tpl" extra_param=$extra_param}>

<input type='hidden' id='xoonips_page' name='page' value='<{$page}>' />

<{if !empty($url_for_get) }>
  <table width="100%" border="0">
   <tr>
    <td colspan='2'  class="even">
      <input type='text' name='url_for_get' value='<{$url_for_get}>' size='80' readonly='readonly' />
    </td>
   </tr>
  </table>
<{/if}>

<{if !empty($print_enabled)}>
 <input type='hidden' id='xoonips_print' name='print' value='0' />
 <input type='button'
 value='<{$smarty.const._MD_XOONIPS_ITEM_PRINT_FRIENDLY_BUTTON_LABEL}>'
 onclick='target="_blank"; $("xoonips_print").value=1; submit(); target=""; $("xoonips_print").value=0;' />
<{/if}>

<{if !empty($export_enabled)}>
 <input type='submit'
 value='<{$smarty.const._MD_XOONIPS_EXPORT_BUTTON_LABEL}>'
 onclick='action="export.php"; op.value="config"; method="post"' />
<{foreach item=i from=$ids}>
 <input type='hidden' name='ids[]' value='<{$i}>'/>
<{/foreach}>
<{/if}>
<br>

<{* Display of tab *}>
<{if isset( $search_tabs ) }>
  <{foreach item=tab from=$search_tabs}>
    <{if $isKHTML }>
        <table  cellspacing="0" style='display: inline-table; border-collapse: separate; border-spacing: 0; width: auto; margin: 0 -1px; position: relative; z-index: 0;'>
      <{else}>
        <table  cellspacing="0" style='display: inline; border-collapse: separate; border-spacing: 0; width: auto; margin: 0 -1px; position: relative; z-index: 0;'>
    <{/if}>
      <{if $tab.search_tab == $search_tab }>
         <tr>
          <td style='background-image: url(<{$smarty.const.XOOPS_URL}>/modules/xoonips/images/a1.gif); width: 5px; height: 3px;'></td>
          <td style='background-image: url(<{$smarty.const.XOOPS_URL}>/modules/xoonips/images/b1.gif); width: auto;'></td>
          <td style='background-image: url(<{$smarty.const.XOOPS_URL}>/modules/xoonips/images/c1.gif); width: 6px; height: 3px;'></td>
         </tr>
         <tr>
          <td style='background-image: url(<{$smarty.const.XOOPS_URL}>/modules/xoonips/images/d1.gif); width: 5px;'></td>
          <td style='background-image: url(<{$smarty.const.XOOPS_URL}>/modules/xoonips/images/e1.gif); width: auto;'><a href="javascript:void(0);" onclick="return false;"><{$tab.label}>(<{$tab.count}>)</a></td>
          <td style='background-image: url(<{$smarty.const.XOOPS_URL}>/modules/xoonips/images/f1.gif); width: 6px;'></td>
         </tr>
        </table>
      <{else}>
         <tr>
          <td style='background-image: url(<{$smarty.const.XOOPS_URL}>/modules/xoonips/images/a0.gif); width: 5px; height: 3px;'></td>
          <td style='background-image: url(<{$smarty.const.XOOPS_URL}>/modules/xoonips/images/b0.gif); width: auto;'></td>
          <td style='background-image: url(<{$smarty.const.XOOPS_URL}>/modules/xoonips/images/c0.gif); width: 6px; height: 3px;'></td>
         </tr>
         <tr>
          <td style='background-image: url(<{$smarty.const.XOOPS_URL}>/modules/xoonips/images/d0.gif); width: 5px;'></td>
          <td style='background-image: url(<{$smarty.const.XOOPS_URL}>/modules/xoonips/images/e0.gif); width: auto;'><a href="javascript:void(0);" onclick="return submit_search_tab('<{$tab.search_tab}>');"><{$tab.label}>(<{$tab.count}>)</a></td>
          <td style='background-image: url(<{$smarty.const.XOOPS_URL}>/modules/xoonips/images/f0.gif); width: 6px;'></td>
         </tr>
        </table>
      <{/if}>
  <{/foreach}>
<{/if}>
<{if isset( $search_tabs ) }>
<div style='border-bottom: 1px solid #404040; border-right: 1px solid #404040;'>
<div style='border: 1px solid #e4e4e4;border-right-color: #858585;border-bottom-color: #858585;padding: 0; margin: 0;'>
<{/if}>
<table width="100%" border="0" cellspacing="5">
<{* item / file List *}>
<{foreach item=i from=$item_htmls}>
  <tr style="vertical-align: top;">
    <td class="<{cycle values="odd,even" name="cycle2"}>">
     <{$i.html}>
    </td>
  </tr>
<{/foreach}>

<{* metadata List *}>
<{foreach item=i from=$metadata}>
  <tr style="vertical-align: top;">
    <td class="<{cycle values="odd,even" name="cycle2"}>">
     <a href='javascript:void(0)' onclick='return showDetail("<{$i.identifier}>");'><{$i.title}></a>
    </td>
  </tr>
<{/foreach}>

</table>
<{if isset( $search_tabs ) }>
</div>
</div>
<{/if}>

<{foreach key=k item=v from=$http_vars}>
 <input type="hidden" name="<{$k}>" value="<{$v}>" />
<{/foreach}>
<{foreach item=id from=$selected}>
 <input type="hidden" name="selected[]" value="<{$id}>" />
<{/foreach}>
<{foreach item=id from=$initially_selected}>
 <input type="hidden" name="initially_selected[]" value="<{$id}>" />
<{/foreach}>
<{foreach item=i from=$query_var_name}>
 <input type="hidden" name="query_var_name[]" value="<{$i}>" />
<{/foreach}>
<{foreach item=i from=$search_var}>
 <input type="hidden" name="search_var[]" value="<{$i}>" />
<{/foreach}>
 <input type="hidden" name="submit_url" value="<{$submit_url}>" />

<input type="hidden" name="index_id" value="<{$index_id}>" />
<input type="hidden" name="search_itemtype" value="<{$search_itemtype}>" />
<input type="hidden" name="search_tab" value="<{$search_tab}>" />
<input type="hidden" name="search_cache_id" value="<{$search_cache_id}>" />

<input id='xoonips_hidden_itemselect_metadata_identifier' type='hidden' name='identifier' value='' />

<{include file="db:xoonips_pagenavi.tpl" maxpage=$maxpage page=$page form_id="xoonips_itemselect"}>
<{include file="db:xoonips_extra_param.tpl" extra_param=$extra_param}>
</form>

<{/if}>

<!-- end module search results loop -->
