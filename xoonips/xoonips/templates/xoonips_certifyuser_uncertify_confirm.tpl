<{* page for certify user *}>

<p>
<{$smarty.const._MI_XOONIPS_ACCOUNT_PANKUZU_MODERATOR}>
<{$smarty.const._MI_XOONIPS_ACCOUNT_PANKUZU_SEPARATOR}>
<{$smarty.const._MD_XOONIPS_MODERATOR_PANKUZU_CERTIFY_USERS}>
<{$smarty.const._MI_XOONIPS_ACCOUNT_PANKUZU_SEPARATOR}>
<{$smarty.const._MD_XOONIPS_MODERATOR_UNCERTIFY_TITLE}>
</p>

<h3><{$smarty.const._MD_XOONIPS_MODERATOR_UNCERTIFY_TITLE}></h3>

<p>
<{$smarty.const._MD_XOONIPS_MODERATOR_UNCERTIFY_DESC}>
</p>

<form name="certifyuser" action="certifyuser.php" method="post">
  <{$token_ticket}>
  <input type="hidden" name="op" value="uncertify" />
  <input type="hidden" name="certify_uid" value="<{$certify_uid}>" />
  <textarea name="comment" rows="10" cols="40" style="width:320px;"></textarea><br>
  <input type="submit" name='is_cancel' value="<{$smarty.const._MD_XOONIPS_MODERATOR_UNCERTIFY_CANCEL_LABEL}>" />
  <input type="submit" name='is_exec' value="<{$smarty.const._MD_XOONIPS_MODERATOR_UNCERTIFY_EXECUTE_LABEL}>" />
</form>
