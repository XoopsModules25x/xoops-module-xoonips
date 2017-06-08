<{* page for certify user *}>

<{* parameters
$users	array of associative array of a user(not yet certified).
$certified_user	associative array of certified user(certify operation only)
$op	operation('certify' or '')

if certification is succeed $op must be 'certify' and $certified_user must be defined.

*}>

<p>
<{$smarty.const._MI_XOONIPS_ACCOUNT_PANKUZU_MODERATOR}>
<{$smarty.const._MI_XOONIPS_ACCOUNT_PANKUZU_SEPARATOR}>
<{$smarty.const._MD_XOONIPS_MODERATOR_PANKUZU_CERTIFY_USERS}>
</p>

<h3><{$smarty.const._MD_XOONIPS_MODERATOR_PANKUZU_CERTIFY_USERS}></h3>

<{if $op=='certify' && !empty( $certified_user ) }>
   <p>
   <{$smarty.const._MD_XOONIPS_USER_CERTIFICATION_SUCCEED}> : <{$certified_user.uname}>
   </p>
<{/if}>

<{if !empty( $users ) }>
<form name="certifyuser" action="certifyuser.php" method="post">
<input type="hidden" name="op" value="certify" />
<input type="hidden" name="certify_uid" value="0" />
<{$token_ticket}>
<{/if}>
<table class="outer" cellspacing="1" cellpadding="4">
  <tr>
    <th><{$smarty.const._US_USERNAME}></th>
    <th><{$smarty.const._US_REALNAME}></th>
    <th><{$smarty.const._US_EMAIL}></th>
    <th><{$smarty.const._MD_XOONIPS_MODERATOR_DETAIL}></th>
    <th><{$smarty.const._MD_XOONIPS_MODERATOR_CERTIFY}></th>
  </tr>
<{if !empty( $users ) }>
<{foreach from=$users item=user}>
  <tr>
    <td class="head"><{$user.uname}></td>
    <td class="<{cycle name="row1" values="even,odd"}>">
      <{$user.name}>
    </td>
    <td class="<{cycle name="row2" values="even,odd"}>">
      <a href='mailto:<{$user.email}>'><{$user.email}></a>
    </td>
    <td class="<{cycle name="row3" values="even,odd"}>">
      <a href='userinfo.php?uid=<{$user.uid}>'><{$smarty.const._MD_XOONIPS_MODERATOR_DETAIL}></a>
    </td>
    <td class="<{cycle name="row4" values="even,odd"}>">
      <input class="formButton" type="button" value="<{$smarty.const._MD_XOONIPS_MODERATOR_CERTIFY}>"
             onclick="this.form.certify_uid.value=<{$user.uid}> submit()"/>
      <input class="formButton" type="button" value="<{$smarty.const._MD_XOONIPS_MODERATOR_UNCERTIFY}>"
             onclick="this.form.op.value = 'uncertify_confirm'; this.form.certify_uid.value=<{$user.uid}> submit()"/>
      </td>
  </tr>
<{/foreach}>
<{else}>
  <tr>
    <td colspan="5" class="even" style="text-align: center;">
      <span style="font-weight: bold; color: red;">
       <{$smarty.const._MD_XOONIPS_MODERATOR_NO_CERTIFY_USERS}>
      </span>
    </td>
  </tr>
<{/if}>
</table>
<{if !empty( $users ) }>
</form>
<{/if}>
