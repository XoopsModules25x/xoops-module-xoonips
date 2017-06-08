<{* show user information *}>
<{include file="db:xoonips_breadcrumbs.inc.tpl"}>
<script type="text/javascript">
<!--//
function xoonips_showusers_select_page( page ) {
  var form = document.getElementById( 'xoonips_showusers_form' );
  form.page.value = page;
  form.submit();
  return false;
}
function xoonips_showusers_select_itemtype( item_type_id ) {
  var form = document.getElementById( 'xoonips_showusers_form' );
  form.item_type_id.value = item_type_id;
  form.submit();
  return false;
}
//--></script>


<div style="text-align: right; margin: 10pt;">
<{if $is_editable}>
  <input class="formButton" type="button" value="<{$smarty.const._US_EDITPROFILE}>" onclick="location='edituser.php?uid=<{$user.uid}>'"/>
<{/if}>
<{if $is_owner}>
  &nbsp;&nbsp;
  <input class="formButton" type="button" value="<{$smarty.const._MD_XOONIPS_ACCOUNT_NOTIFICATIONS}>" onclick="location='notifications.php'"/>
<{/if}>
</div>

<table border="0" width="100%">
 <tr>
  <td width="10%" rowspan="2" style="text-align: center;">
   <img src="<{$user_avatarurl}>" alt="Avatar"/>
  </td>
  <th width="90%" style="padding-left: 10px;">
   <{if !empty($user.name)}><{$user.name}><{else}><{$user.uname}><{/if}>
  </th>
 </tr>
 <tr>
  <td class="even" style="padding-left: 10px;">
   <{$xuser.company_name}><br>
   <{$xuser.division}><br>
   <{$position}>
  </td>
 </tr>
 <tr>
  <td style="text-align: center;">
   <{if $is_owner}>
    <input class="formButton" type="button" value="<{$smarty.const._US_AVATAR}>" onclick="location='edituser.php?op=avatarform'"/>
   <{else}>
    <input class="formButton" type="button" value="<{$smarty.const._MD_XOONIPS_SEND_MESSAGE}>" onclick="openWithSelfMain('<{$xoops_url}>/pmlite.php?send2=1&amp;to_userid=<{$user.uid}>', 'pmlite', 450, 380);"/> 
   <{/if}>
  </td>
 </tr>
 <tr><td>&nbsp;</td></tr>
 <tr>
  <td colspan="2" style="padding-left: 15px;">
   <{$xuser.appeal}>
  </td>
 </tr>
</table>
<br>

<{* display curriculum vitae *}>
<div style="margin: 15px;">
 <b><{$smarty.const._MD_XOONIPS_SHOW_CV_LABEL}></b>
 <{if $is_owner}>
  &nbsp;
  <input class="formButton" type="button" value="<{$smarty.const._MD_XOONIPS_EDIT_LISTS}>" onclick="location='editcvitae.php'"/>
 <{/if}>
<{if ! empty( $cvitaes ) }>
<table border="0" width="100%">
 <{foreach from=$cvitaes item=cv}>
 <tr class="<{cycle name="cvitaes" values="odd,even"}>">
   <td width="20%"><{$cv.from_month}><{$cv.from_year}></td>
   <td width="5%"><{if $cv.from_month == '' && $cv.from_year == '' && $cv.to_month == '' && $cv.to_year == '' }>&nbsp;<{else}>-<{/if}></td>
   <td width="20%"><{$cv.to_month}> <{$cv.to_year}></td>
   <td width="55%" style="padding-left: 15px;"><{$cv.title}></td>
 </tr>
 <{/foreach}>
</table>
<{/if}>
</div>

<{* display publication list *}>
<div style="margin: 15px;">
 <b><{$smarty.const._MD_XOONIPS_SHOW_PUBILICATION_LIST}></b>
 <{if $is_owner}>
  &nbsp;
  <input class="formButton" type="button" value="<{$smarty.const._MD_XOONIPS_EDIT_LISTS}>" onclick="location='editshowitem.php'"/>
 <{/if}>
<{if ! empty( $publications ) }>
<form id="xoonips_showusers_form" name="xoonips_showusers_form" action="showusers.php" method="post">
<input type="hidden" name="uid" value="<{$user.uid}>"/>
<input type="hidden" name="item_type_id" value="<{$item_type_id}>"/>
<input type="hidden" name="page" value="<{$page}>"/>
</form>
<{* --- BEGIN: tab --- *}>
<div>
 <ul>
<{foreach from=$tabs item=tab}>
     <li style="float:left; padding: 0 1px; list-style:none; height:21px; vertical-align: middle;"><a href="javascript:void(0);"
                                                                                                      onclick="return <{$tab.onclick}>(<{$tab.id}>)"
                                                                                                      style="background: url( <{$xoops_url}>/modules/xoonips/images/tab_<{if $tab.selected}>active<{else}>inactive<{/if}>_left.gif; ) no-repeat left top; height 21px; float:left; padding-left: 5px; text-decoration: none;"><span
             style="background: url( <{$xoops_url}>/modules/xoonips/images/tab_<{if $tab.selected}>active<{else}>inactive<{/if}>_right.gif;) no-repeat right top; padding: 5px 5px 0 0;height: 21px; float:left; white-space: nowrap;"><{$tab.label}></span></a>
     </li>
     <{/foreach}>
 </ul>
</div>
<div style="clear:both;"></div>
<{* --- END: tab --- *}>
<div style="border-right: 1px solid #404040; border-bottom: 1px solid #404040;">
<div style="border-style: solid; border-color: #e4e4e4 #858585 #858585 #e4e4e4; border-width: 1px; margin: 0; padding: 0;">
<{* --- BEGIN: navi --- *}>
<{if $navi.total > 1}>
<div style="margin: 5px;">
<div style="float: left;">
  <{if $navi.total > 1}>
  <{$navi.start}> - <{$navi.end}> of <{$navi.total}> Items
  <{/if}>
</div>
<{if $navi.maxpage > 1}>
<div style="float: right; white-space: nowrap;">
<{if $navi.prev}><a href="javascript:void(0);" onclick="<{$navi.onclick}>(<{$navi.prev}>)">PREV</a><{else}>PREV<{/if}>&nbsp;
<{foreach from=$navi.navi item=page}>
  <{if $navi.page != $page}><a href="javascript:void(0);" onclick="<{$navi.onclick}>(<{$page}>)"><{$page}></a><{else}><{$page}><{/if}>&nbsp;
<{/foreach}>
<{if $navi.next}><a href="javascript:void(0);" onclick="<{$navi.onclick}>(<{$navi.next}>)">NEXT</a><{else}>NEXT<{/if}>
</div>
<{/if}>
<div style="clear: both;"></div>
</div>
<{/if}>
<{* --- END: navi --- *}>
<table border="0" width="100%">
<{foreach from=$publications item=item}>
 <tr>
  <td class="<{cycle name="publications" values="odd,even"}>">
   <{$item}>    
  </td>
 </tr>
<{/foreach}>
</table>
<{* --- BEGIN: navi --- *}>
<{if $navi.total > 1}>
<div style="margin: 5px;">
<div style="float: left;">
  <{if $navi.total > 1}>
  <{$navi.start}> - <{$navi.end}> of <{$navi.total}> Items
  <{/if}>
</div>
<{if $navi.maxpage > 1}>
<div style="float: right; white-space: nowrap;">
<{if $navi.prev}><a href="javascript:void(0);" onclick="<{$navi.onclick}>(<{$navi.prev}>)">PREV</a><{else}>PREV<{/if}>&nbsp;
<{foreach from=$navi.navi item=page}>
  <{if $navi.page != $page}><a href="javascript:void(0);" onclick="<{$navi.onclick}>(<{$page}>)"><{$page}></a><{else}><{$page}><{/if}>&nbsp;
<{/foreach}>
<{if $navi.next}><a href="javascript:void(0);" onclick="<{$navi.onclick}>(<{$navi.next}>)">NEXT</a><{else}>NEXT<{/if}>
</div>
<{/if}>
<div style="clear: both;"></div>
</div>
<{/if}>
<{* --- END: navi --- *}>
</div>
</div>
<{/if}>
</div>

<{* signature *}>
<div style="margin: 15px;">
<{$user.signature}>
</div>

<{* go back to user list *}>
<div style="text-align: right;">
<a href="userlist.php"><{$smarty.const._MD_XOONIPS_SHOW_BACKTOLIST_LABEL}></a>
</div>
