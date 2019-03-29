<h3><{$smarty.const._MD_XOONIPS_ITEM_REGISTER_ITEM_CONFIRM}></h3>

<{*
template for displaying to confirm registered item


$body: HTML of form to confirm registered item
$http_vars: Hash table of parameters send to the following page (item information, etc...)
$system_message: messages or errors from system (it is possible to omit it.)
$select_private_index_auto: assign this if /Private is selected automatically(by XooNIps)
*}>

<{*
<br>
<{$smarty.const._MD_XOONIPS_ITEM_REGISTER_ITEM_CONFIRM_MESSAGE}>
<br>
*}>

<form name='confirm' action="confirm_register.php" method="post">
<{if !empty( $select_private_index_auto )}>
 <span id='message_label_top' style='display: block; color: red;'>
  <{$smarty.const._MD_XOONIPS_ITEM_SELECT_PRIVATE_INDEX_AUTO}>
 </span>
<{/if}>

<p>
<{$system_message}>
</p>
<{$body}>

<{foreach key=k item=v from=$http_vars}>
 <input type="hidden" name="<{$k}>" value="<{$v}>" />
<{/foreach}>

<input type="hidden" name="op" value="<{$op}>" />

<div style="text-align: center; margin-top: 20px;">
 <input class="formButton" type="button" value="<{$smarty.const._MD_XOONIPS_ITEM_BACK_BUTTON_LABEL}>" onclick="document.confirm.action='register.php'; submit();" />
<{if $register_button_visible}>
 <input class="formButton" type="submit" value="<{$smarty.const._MD_XOONIPS_ITEM_REGISTER_BUTTON_LABEL}>" />
<{/if}>
</div>

<{$token_hidden}>
</form>
