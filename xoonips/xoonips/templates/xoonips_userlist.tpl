<{* Display users information *}>

<h3><{$smarty.const._MD_XOONIPS_USERLIST_TITLE}></h3>

<div style="margin: 0 10px 10px 10px;">
  <div style="text-align: left; float: left;">
    <{$smarty.const._MD_XOONIPS_USERLIST_EXPLANATION}>
  </div>
  <div style="text-align: right; float: right;">
<{if $is_user}>
    <input class="formButton" type="button" value="<{$smarty.const._MD_XOONIPS_SHOW_USER_TITLE}>" onclick="location='showusers.php'"/>
<{/if}>
  </div>
  <div style="clear: both;"></div>
</div>

<{if $userslist}>
<table>
<{foreach item=position from=$userslist}>
  <tr><td>&nbsp;</td></tr>
  <tr><th><{$position.title}></th></tr>
  <{foreach item=user from=$position.users}>
  <tr>
    <td style="padding-left: 20px;"><a href="showusers.php?uid=<{$user.uid}>"><{if $user.name}><{$user.name}><{else}><{$user.uname}><{/if}></a></td>
  </tr>
  <{/foreach}>
<{/foreach}>
</table>
<{/if}>
