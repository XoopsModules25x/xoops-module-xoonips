<{* page for activate user *}>
<{* $Revision: 1.1.2.1 $ *}>

<{* parameters
$op
$id
$actkey
*}>

<form action="user.php" method="post">
<input type="hidden" name="op" value="<{$op}>" />
<input type="hidden" name="id" value="<{$id}>" />
<input type="hidden" name="actkey" value="<{$actkey}>" />
<{$smarty.const._MD_XOONIPS_PUSH_BUTTON_TO_ACTIVATE}><br>
<input type="submit" value="<{$smarty.const._MD_XOONIPS_ACTIVATE}>" />
<{$token_ticket}>
</form>
