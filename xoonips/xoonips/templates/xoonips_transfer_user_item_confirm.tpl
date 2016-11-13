<script type="text/javascript" src="js/prototype.js">
</script>

<div class='xoonips_page_title'>
<{$smarty.const._MD_XOONIPS_TRANSFER_USER_ITEM_CONFIRM_PAGE_TITLE}>
</div>

<{$smarty.const._MD_XOONIPS_TRANSFER_USER_ITEM_CONFIRM_PAGE_DESCRIPTION}>
<form id='xoonips_form_transfer_item_confirm' action='transfer_item.php?action=request' method='post'>

<{if !$is_user_in_groups}>
<{$not_subscribed_group_message}><br>
<{/if}>

<br>

<table class='outer'>
 <thead>
  <tr>
   <th><{$smarty.const._MD_XOONIPS_TRANSFER_USER_ITEM_CONFIRM_ITEM_ID}></th>
   <th><{$smarty.const._MD_XOONIPS_TRANSFER_USER_ITEM_CONFIRM_ITEM_TYPE}></th>
   <th><{$smarty.const._MD_XOONIPS_TRANSFER_USER_ITEM_CONFIRM_TITLE}></th>
  </tr>
 </thead>
 <tbody>
<{if !empty( $transfer_items ) }>
<{foreach item=item from=$transfer_items}>
  <tr class='<{cycle values="odd,even"}>'>
   <td><{$item.item_id}></td>
   <td><{$item.item_type_name}></td>
   <td>
    <a href="transfer_item.php?action=detail_item&amp;item_id=<{$item.item_id}>"
       target="xoonips_windows_transfer_user_item_detail">
<{$item.title}>
    </a>
   </td>
  </tr>
<{/foreach}>
<{else}>
 <tr>
  <td class="even" style="text-align: center;" colspan="3"><span style="font-weight: bold; color: red;"><{$smarty.const._MD_XOONIPS_TRANSFER_USER_ITEM_CONFIRM_NO_TRANSFER_ITEMS}></span></td>
 </tr>
<{/if}>
 </tbody>
</table>


<br>
<{$smarty.const._MD_XOONIPS_TRANSFER_USER_ITEM_CONFIRM_TO}>
<{$to_uname}>

<br>
<br>

<input id='xoonips_button_submit' type='submit' value='<{$smarty.const._MD_XOONIPS_TRANSFER_USER_ITEM_CONFIRM_SUBMIT}>' 
<{if !$is_user_in_groups || empty( $transfer_items )}>disabled="disabled"<{/if}>/>
<input id='xoonips_button_back' type='submit' onclick="$('xoonips_form_transfer_item_confirm').action='transfer_item.php?action=request_initialize';" value='<{$smarty.const._MD_XOONIPS_TRANSFER_USER_ITEM_CONFIRM_BACK}>' />

<{foreach item=item_id from=$item_ids_to_transfer}>
<input type='hidden' name='item_ids_to_transfer[]' value='<{$item_id}>'/>
<{/foreach}>

<{foreach item=child_item_ids from=$child_item_ids_to_transfer}>
<{foreach item=item_id from=$child_item_ids}>
<input type='hidden' name='child_item_ids_to_transfer[]' value='<{$item_id}>'/>
<{/foreach}>
<{/foreach}>

<input type='hidden' name='to_uid' value='<{$to_uid}>' />

<{$token_hidden}>
</form>
