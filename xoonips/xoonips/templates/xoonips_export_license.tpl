<p>
<{$smarty.const._MD_XOONIPS_EXPORT_PANKUZU_EXPORT}>
<{$smarty.const._MI_XOONIPS_ACCOUNT_PANKUZU_SEPARATOR}>
<{$smarty.const._MD_XOONIPS_EXPORT_PANKUZU_EXPORT_LICENSE}>
</p>

<{*


$system_message	a string of error, warning, nottice messages

//item which should take agreement of a license
//do not define, when number of items is zero.
$item.license_required[].item_id:     id of item
$item.license_required[].detail_html: summary of item (in HTML)
$item.license_required[].license:     contents of licence

//when item can not export
//do not define, when number of items is zero.
$item.not_export[].item_id:     id of item
$item.not_export[].detail_html: summary of item (in HTML)
$item.not_export[].license:     contents of licence

//export item
$item.export[].item_id:     id of item
$item.export[].detail_html: summary of item (in HTML)
$item.export[].license:     contents of licence

$index_id:   id of index, when exported in specified index. (others: nothing)
$attachment: export attachment files (1/0)
$recursive:  export index recursively (1/0)
$export_type: export item or index tree structure( 'item' or 'index' )
*}>

<script language="JavaScript" type="text/javascript">
<!--
function setCheckboxes(elements, do_check)
{
    if( typeof(elements.length) != 'undefined' ){
        for (var i = 0; i < elements.length; i++) {
            elements[i].checked = do_check;
        }
    }else{
        elements.checked = do_check;
    }
}
//-->
</script>

<br>
<{$system_message}>
<br>
<form name="exportinfo" action="export.php" method="post">
<div style="margin: 10px; text-align: center;"><input class="formButton" type="submit" value="<{$smarty.const._MD_XOONIPS_EXPORT_LICENSE_AGREEMENT_SUBMIT}>"/></div>
<input type="hidden" name="op" value="export"/>
<{if !empty($index_id)}>
<input type="hidden" name="index_id" value="<{$index_id}>"/>
<{/if}>
<{if !empty($attachment)}>
<input type="hidden" name="attachment" value="<{$attachment}>"/>
<{/if}>
<{if !empty($recursive_item)}>
<input type="hidden" name="recursive_item" value="<{$recursive_item}>"/>
<{/if}>
<{if !empty($recursive_index)}>
<input type="hidden" name="recursive_index" value="<{$recursive_index}>"/>
<{/if}>
<{if !empty($export_type)}>
<input type="hidden" name="export_type" value="<{$export_type}>"/>
<{/if}>
<{if !empty($item.export)}>
<{foreach item=i from=$item.export}>
<input type="hidden" name="ids[]" value="<{$i.item_id}>"/>
<{/foreach}>
<{/if}>
<{if !empty($item.license_required)}>
<input type="checkbox" name="acceptall" onclick="setCheckboxes(form.elements['ids[]'],form.acceptall.checked);"/>
<{$smarty.const._MD_XOONIPS_EXPORT_ACCEPT_ALL}>
<{/if}>
<table width="100%" class="outer" cellspacing="1">
 <tr>
  <th colspan="2"><{$smarty.const._MD_XOONIPS_EXPORT_EXPORT_LICENSE}></th>
 </tr>
 
<{if empty($item.license_required)}>
 <tr valign="top" align="left">
  <td class="<{cycle values="odd,even"}>"><{$smarty.const._MD_XOONIPS_EXPORT_NO_ITEMS_FOUND}></td>
 </tr>
<{else}>
<{foreach item=i from=$item.license_required}>
 <!-- Item -->
 <tr valign="top" align="left" class="<{cycle values="odd,even"}>">
  <td class="head">
   <table>
    <tr valign="top" align="left">
     <th>Item</th>
    </tr>
    <tr>
     <td>
      <{$i.detail_html}>
     </td>
    </tr>
    <tr valign="top" align="left">
     <th><{$smarty.const._MD_XOONIPS_EXPORT_LICENSE}></th>
    </tr>
    <tr valign="top" align="left">
     <td valign="middle"><input type="checkbox" name="ids[]" value="<{$i.item_id}>"/><{$smarty.const._MD_XOONIPS_EXPORT_ACCEPT}></td>
    </tr>
    <tr valign="top" align="left">
     <td class="head">
<{if !empty($i.use_cc) }>
       <{$i.license}>
<{else}>
       <textarea rows="5" cols="70" readonly="readonly" style="width:400px;"><{$i.license}></textarea>
<{/if}>
     </td>
    </tr>
   </table>
  </td>
 </tr>
<{/foreach}> 
<{/if}>
</table>

<table width="100%" class="outer" cellspacing="1">
 <tr>
  <th colspan="2"><{$smarty.const._MD_XOONIPS_EXPORT_CANNOT_BE_EXPORTED_ITEMS}></th>
 </tr>
<{if empty($item.not_export)}>
 <tr valign="top" align="left">
  <td class="<{cycle values="odd,even"}>"><{$smarty.const._MD_XOONIPS_EXPORT_NO_ITEMS_FOUND}></td>
 </tr>
<{else}>
 <{foreach item=i from=$item.not_export}>
  <tr valign="top" align="left">
   <td class="<{cycle values="odd,even"}>">
    <{$i.detail_html}>
   </td>
  </tr>
 <{/foreach}>
<{/if}>
</table>

<div style="margin: 10px; text-align: center;"><input class="formButton" type="submit" value="<{$smarty.const._MD_XOONIPS_EXPORT_LICENSE_AGREEMENT_SUBMIT}>"/></div>
</form>
