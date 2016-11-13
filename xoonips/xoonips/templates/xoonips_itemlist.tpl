<{*

$index
$index_path
$item
$item_count_label
$item_count_select
$item_htmls
$itemcount
$num_of_items
$maxpage
$my_indexes
$order_by_label
$order_by_select
$page
$page_no_label
$pages
$order_dir
$title_page
$edit_index: id of index to edit(call edit index page from this page)
$export_enabled: when user can export item in this page, this parameter is defined.

*}>
<script type='text/javascript'>
<!--
<{if $index_id != $smarty.const.IID_ROOT && $index_id != $smarty.const.IID_BINDERS && $add_button_visible == 1}>
function submit_add_to_index()
{
    var form = document.getElementById('xoonips_add_to_index_form');
    form.submit();
    return false;
}
<{/if}>

<{if $edit_index }>
function submit_edit_index()
{
    var form = document.getElementById('xoonips_edit_index_form');
    form.submit();
    return false;
}
<{/if}>

function submit_itemlist_printer_friendly(){
    var form = document.getElementById('xoonips_itemlist_printer_friendly_form');
    form.submit();
    return false;
}

function submit_order_dir( str )
{
    var form = document.getElementById('xoonips_order_itemcount_form');
    form.order_dir.value = str;
    form.submit();
    return false;
}

// -->
</script>

<h3><{$title_page}></h3>

<{if isset($index_path) }>
<form action="export.php" method="post">
<{foreach item=index from=$index_path}>
 / <a href="listitem.php?index_id=<{$index.item_id}>"><{$index.html_title}></a>
<{/foreach}>
<{* ROOT, Binders: not display 'Add' button *}>
<{if $index_id != $smarty.const.IID_ROOT && $index_id != $smarty.const.IID_BINDERS && $add_button_visible == 1}>
 &nbsp;&nbsp;
 <input class="formButton" type="button" name="add" value="<{$smarty.const._MD_XOONIPS_ITEM_ADD_ITEM_BUTTON_LABEL}>" onclick="submit_add_to_index();"/>
<{/if}>
<{* button: move to edit index page *}>
<{if $edit_index }>
 &nbsp;&nbsp;
 <input class="formButton" type="button" name="edit_index" value="<{$smarty.const._MD_XOONIPS_ITEM_EDIT_INDEX_BUTTON_LABEL}>" onclick="submit_edit_index();"/>
<{/if}>
<{* button: export index *}>
 &nbsp;&nbsp;
<{if !empty($export_enabled)}>
<input type="hidden" name="op" value=""/>
<input class="formButton" type="button" value="<{$smarty.const._MD_XOONIPS_EXPORT_BUTTON_LABEL}>"
onclick="form.action='export.php'; op.value='config'; submit();"/>
<input type="hidden" name="index_id" value="<{$index.item_id}>"/>
<{/if}>
<{* buttom: display Printer Friendly page *}>
<{if !empty($print_enabled)}>
 &nbsp;&nbsp;
<input class="formButton" type="button" value="<{$smarty.const._MD_XOONIPS_ITEM_PRINT_FRIENDLY_BUTTON_LABEL}>" onclick="submit_itemlist_printer_friendly();"/>
<{/if}>
</form>
<{* index list *}>
<{foreach item=idx from=$my_indexes name=my_idx}>
<{if $smarty.foreach.my_idx.first}>
<table width="100%" border="0" cellspacing="5">
<{/if}>
  <tr valign="top">
    <td class="<{cycle values="odd,even"}>">
     <{$idx}>
    </td>
  </tr>
<{if $smarty.foreach.my_idx.last}>
</table>
<{/if}>
<{/foreach}>
<{/if}>

<{if $item_htmls}>
<form action="" id="xoonips_order_itemcount_form">
<div style="text-align: center;">
<table width="100%" border="0" cellspacing="5">
  <tr valign="top">
    <td class="odd">
     <{$order_by_label}>
     <select name="orderby" onchange="submit();">
<{foreach key=key item=item from=$order_by_select}>
      <option value="<{$key}>" <{if $key==$orderby}> selected="selected" <{/if}> ><{$item}></option>
<{/foreach}>
     </select>
    <input type="hidden" name="order_dir" value="<{$order_dir}>"/>
<{if $order_dir == $smarty.const.ASC }>
    <{$smarty.const._MD_XOONIPS_ITEM_ASCEND}>
    <a href="#" onclick="return submit_order_dir('<{$smarty.const.DESC}>');"><{$smarty.const._MD_XOONIPS_ITEM_DESCEND}></a>
<{else}>
    <a href="#" onclick="return submit_order_dir('<{$smarty.const.ASC }>');"><{$smarty.const._MD_XOONIPS_ITEM_ASCEND}></a>
    <{$smarty.const._MD_XOONIPS_ITEM_DESCEND}>
<{/if}>
    </td>
    <td class="odd">
     <{$item_count_label}>
     <select name="itemcount" onchange="submit();">
<{foreach item=i from=$item_count_select}>
      <option value="<{$i}>" <{if $i==$itemcount }> selected="selected" <{/if}> ><{$i}></option>
<{/foreach}>
     </select>
    </td>
  </tr>
</table> 
</div>
<input type="hidden" name="page" value="1"/>
<input type="hidden" name="num_of_items" value="<{$num_of_items}>"/>
<{if $index_id > 0}>
<input type="hidden" name="index_id" value="<{$index_id}>"/>
<{/if}>
</form>
<{/if}>

<{if $page_no_label}><p><{$page_no_label}></p><{/if}>

<{if $maxpage > 1}>
<div align="right">
<{if $page > 1}>
<{if $index_id > 0}>
<a href="?index_id=<{$index_id}>&amp;page=<{$page-1}>&amp;orderby=<{$orderby}>&amp;itemcount=<{$itemcount}>&amp;num_of_items=<{$num_of_items}>">PREV</a>&nbsp;
<{else}>
<a href="?page=<{$page-1}>&amp;orderby=<{$orderby}>&amp;itemcount=<{$itemcount}>&amp;num_of_items=<{$num_of_items}>">PREV</a>&nbsp;
<{/if}>
<{else}>
PREV&nbsp;
<{/if}>

<{foreach item=i from=$pages}>
<{if $i==$page}>
<{$i}>
<{else}>
 <{if $index_id > 0}>
<a href="?index_id=<{$index_id}>&amp;page=<{$i}>&amp;orderby=<{$orderby}>&amp;itemcount=<{$itemcount}>&amp;num_of_items=<{$num_of_items}>"><{$i}></a>
 <{else}>
<a href="?page=<{$i}>&amp;orderby=<{$orderby}>&amp;itemcount=<{$itemcount}>&amp;num_of_items=<{$num_of_items}>"><{$i}></a>
 <{/if}>
<{/if}>
&nbsp;
<{/foreach}>

<{if $page < $maxpage }>
 <{if $index_id > 0}>
<a href="?index_id=<{$index_id}>&amp;page=<{$page+1}>&amp;orderby=<{$orderby}>&amp;itemcount=<{$itemcount}>&amp;num_of_items=<{$num_of_items}>">NEXT</a>
 <{else}>
<a href="?page=<{$page+1}>&amp;orderby=<{$orderby}>&amp;itemcount=<{$itemcount}>&amp;num_of_items=<{$num_of_items}>">NEXT</a>
 <{/if}>
<{else}>
NEXT
<{/if}>
</div>
<{/if}>

<{if $item_htmls}>
<table width="100%" border="0" cellspacing="5">
<{foreach item=i from=$item_htmls}>
  <tr valign="top">
    <td  class="<{cycle values="odd,even"}>">
     <{$i.html}>
    </td>
  </tr>
<{/foreach}>
</table>
<{/if}>

<{if $maxpage > 1}>
<div align="right">
<{if $page > 1}>
<{if $index_id > 0}>
<a href="?index_id=<{$index_id}>&amp;page=<{$page-1}>&amp;orderby=<{$orderby}>&amp;itemcount=<{$itemcount}>&amp;num_of_items=<{$num_of_items}>">PREV</a>&nbsp;
<{else}>
<a href="?page=<{$page-1}>&amp;orderby=<{$orderby}>&amp;itemcount=<{$itemcount}>&amp;num_of_items=<{$num_of_items}>">PREV</a>&nbsp;
<{/if}>
<{else}>
PREV&nbsp;
<{/if}>

<{foreach item=i from=$pages}>
<{if $i==$page}>
<{$i}>
<{else}>
 <{if $index_id > 0}>
<a href="?index_id=<{$index_id}>&amp;page=<{$i}>&amp;orderby=<{$orderby}>&amp;itemcount=<{$itemcount}>&amp;num_of_items=<{$num_of_items}>"><{$i}></a>
 <{else}>
<a href="?page=<{$i}>&amp;orderby=<{$orderby}>&amp;itemcount=<{$itemcount}>&amp;num_of_items=<{$num_of_items}>"><{$i}></a>
 <{/if}>
<{/if}>
&nbsp;
<{/foreach}>

<{if $page < $maxpage }>
 <{if $index_id > 0}>
<a href="?index_id=<{$index_id}>&amp;page=<{$page+1}>&amp;orderby=<{$orderby}>&amp;itemcount=<{$itemcount}>&amp;num_of_items=<{$num_of_items}>">NEXT</a>
 <{else}>
<a href="?page=<{$page+1}>&amp;orderby=<{$orderby}>&amp;itemcount=<{$itemcount}>&amp;num_of_items=<{$num_of_items}>">NEXT</a>
 <{/if}>
<{else}>
NEXT
<{/if}>
</div>
<{/if}>

<br>

<{if $index_id != $smarty.const.IID_ROOT && $index_id != $smarty.const.IID_BINDERS && $add_button_visible == 1}>
<form action="advanced_search_add_to_index.php" method="post" id="xoonips_add_to_index_form">
<input type="hidden" name="add_to_index_id" value="<{$index_id}>"/>
<input type="hidden" name="checkbox" value="on"/>
</form>
<{/if}>
<{if $edit_index }>
<form action="editindex.php" method="get" id="xoonips_edit_index_form">
<input type="hidden" name="index_id" value="<{$index_id}>"/>
</form>
<{/if}>
<form action="listitem.php" method="get" id="xoonips_itemlist_printer_friendly_form" target="_blank">
<input type="hidden" name="index_id" value="<{$index_id}>"/>
<input type="hidden" name="orderby" value="<{$orderby}>"/>
<input type="hidden" name="page" value="<{$page}>"/>
<input type="hidden" name="itemcount" value="<{$itemcount}>"/>
<input type="hidden" name="num_of_items" value="<{$num_of_items}>"/>
<input type="hidden" name="print" value="1"/>
</form>
