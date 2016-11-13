<script type="text/javascript" src="../js/prototype.js">
</script>

<{foreach item=i from=$group_names_to_subscribe_messages}>
<{$i}><br>
<{/foreach}>
<{if $limit_check_result}>
<{$smarty.const._AM_XOONIPS_MAINTENANCE_TRANSFER_ADMIN_ITEM_LIST_LIMIT_CHECK_OUT_OF_BOUNDS}>
<{/if}>

<{foreach item=i from=$can_not_transfer_items.request_certify}>
<{$i|string_format:$smarty.const._AM_XOONIPS_MAINTENANCE_TRANSFER_ADMIN_ITEM_LIST_CAN_NOT_TRANSFER_REQUEST_CERTIFY_ITEM}><br>
<{/foreach}>

<{foreach item=i from=$can_not_transfer_items.request_transfer}>
<{$i|string_format:$smarty.const._AM_XOONIPS_MAINTENANCE_TRANSFER_ADMIN_ITEM_LIST_CAN_NOT_TRANSFER_REQUEST_TRANSFER_ITEM}><br>
<{/foreach}>

<{foreach item=i from=$can_not_transfer_items.have_another_parent}>
<{$i|string_format:$smarty.const._AM_XOONIPS_MAINTENANCE_TRANSFER_ADMIN_ITEM_LIST_CAN_NOT_TRANSFER_HAVE_ANOTHER_PARENT_ITEM}><br>
<{/foreach}>

<{foreach item=i from=$can_not_transfer_items.child_request_certify}>
<{$i|string_format:$smarty.const._AM_XOONIPS_MAINTENANCE_TRANSFER_ADMIN_ITEM_LIST_CAN_NOT_TRANSFER_CHILD_REQUEST_CERTIFY_ITEM}><br>
<{/foreach}>

<{foreach item=i from=$can_not_transfer_items.child_request_transfer}>
<{$i|string_format:$smarty.const._AM_XOONIPS_MAINTENANCE_TRANSFER_ADMIN_ITEM_LIST_CAN_NOT_TRANSFER_CHILD_REQUEST_TRANSFER_ITEM}><br>
<{/foreach}>

<br>

<form id='xoonips_form_transfer_admin_item_list' action='maintenance.php?page=item&amp;action=tupdate' method='post'>

<{$smarty.const._AM_XOONIPS_MAINTENANCE_TRANSFER_ADMIN_ITEM_LIST_FROM}>
&nbsp;
<{$smarty.const._AM_XOONIPS_MAINTENANCE_TRANSFER_ADMIN_ITEM_LIST_USER_NAME}>
<{$from_uname}>
&nbsp;
<{$smarty.const._AM_XOONIPS_MAINTENANCE_TRANSFER_ADMIN_ITEM_LIST_INDEX_NAME}>
<{$from_index_path}>

<table class='outer'>
 <thead>
  <tr>
   <th><{$smarty.const._AM_XOONIPS_MAINTENANCE_TRANSFER_ADMIN_ITEM_LIST_ITEM_ID}></th>
   <th><{$smarty.const._AM_XOONIPS_MAINTENANCE_TRANSFER_ADMIN_ITEM_LIST_ITEM_TYPE}></th>
   <th><{$smarty.const._AM_XOONIPS_MAINTENANCE_TRANSFER_ADMIN_ITEM_LIST_TITLE}></th>
  </tr>
 </thead>
 <tbody>
<{if !empty( $transfer_items ) }>
<{foreach item=i from=$transfer_items}>
  <tr class='<{cycle values="odd,even"}>'>
   <td><{$i.item_id}></td>
   <td><{$i.item_type_name}></td>
   <td>
    <a href="<{$smarty.const.XOOPS_URL}>/modules/xoonips/transfer_item.php?action=detail_item&amp;item_id=<{$i.item_id}>" target="xoonips_windows_transfer_user_item_detail"><{$i.title}></a>
<{foreach item=j from=$i.child_titles}>
    <br><{$j|indent:1:"&nbsp;&nbsp;"}>
<{/foreach}>
   </td>
  </tr>
<{/foreach}>
<{else}>
 <tr>
  <td class="even" style="text-align: center;" colspan="3"><span style="font-weight: bold; color: red;"><{$smarty.const._AM_XOONIPS_MAINTENANCE_TRANSFER_ADMIN_ITEM_LIST_NO_ITEMS_SELECTED}></span></td>
 </tr>
<{/if}>
 </tbody>
</table>

<{$smarty.const._AM_XOONIPS_MAINTENANCE_TRANSFER_ADMIN_ITEM_LIST_TO}>
&nbsp;
<{$smarty.const._AM_XOONIPS_MAINTENANCE_TRANSFER_ADMIN_ITEM_LIST_USER_NAME}>
<{$to_uname}>
&nbsp;
<{$smarty.const._AM_XOONIPS_MAINTENANCE_TRANSFER_ADMIN_ITEM_LIST_INDEX_NAME}>
<{$to_index_path}>

<br>
<br>

<div class='xoonips_transfer_admin_item_list_buttons'>
 <input id='xoonips_button_cancel' type='submit' onclick="$('xoonips_form_transfer_admin_item_list').action='maintenance.php?page=item&amp;action=transfer';" value='<{$smarty.const._AM_XOONIPS_MAINTENANCE_TRANSFER_ADMIN_ITEM_LIST_CANCEL}>'/>
 <input id='xoonips_button_submit' type='submit' value='<{$smarty.const._AM_XOONIPS_MAINTENANCE_TRANSFER_ADMIN_ITEM_LIST_SUBMIT}>' 
 <{if count($item_ids_transfer_disabled)>0 || empty( $transfer_items )}> disabled="disabled" <{/if}>/>
</div>

<{foreach item=i from=$item_ids_to_transfer}>
<input type='hidden' name='item_ids_to_transfer[]' value='<{$i}>'/>
<{/foreach}>
<{foreach item=i from=$child_item_ids_to_transfer}>
<input type='hidden' name='child_item_ids_to_transfer[]' value='<{$i}>'/>
<{/foreach}>
<{foreach item=i from=$group_ids_to_subscribe}>
<input type='hidden' name='group_ids_to_subscribe[]' value='<{$i}>'/>
<{/foreach}>
<input type='hidden' name='from_uid' value='<{$from_uid}>'/>
<input type='hidden' name='to_uid' value='<{$to_uid}>'/>
<input type='hidden' name='to_index_id' value='<{$to_index_id}>'/>

<{$token_hidden}>
</form>
