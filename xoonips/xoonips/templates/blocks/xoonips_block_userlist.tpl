<{* user list block *}>
<{* $Revision: 1.1.4.1 $ *}>
<table style="width: 90%;">
<{foreach item=position from=$block.positions}>
 <tr>
  <td style="text-align: left;">
    <div style="font-weight: bold;">
      <{$position.title}>
    </div>
    <div style="margin-left: 1em;">
    <{foreach item=user from=$position.users name=users}>
      <a href="<{$xoops_url}>/modules/xoonips/showusers.php?uid=<{$user.uid}>"><{if $user.name }><{$user.name}><{else}><{$user.uname}><{/if}></a>
      <{if !$smarty.foreach.users.last}><br><{/if}>
    <{/foreach}>
    </div>
  </td>
 </tr>
<{/foreach}>
</table>
