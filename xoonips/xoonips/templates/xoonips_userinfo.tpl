<{* page to display users information *}>
<{if $user_ownpage == true}>

<p>
<{$smarty.const._MI_XOONIPS_ACCOUNT_PANKUZU_PLATFORM_USER}>
<{$smarty.const._MI_XOONIPS_ACCOUNT_PANKUZU_SEPARATOR}>
<{$smarty.const._MI_XOONIPS_ITEM_PANKUZU_VIEW_ACCOUNT}>
</p>

<form name="usernav" action="user.php" method="post">

<br><br>

<table width="70%" align="center" border="0">
  <tr align="center">
    <td>
    <input class="formButton" type="button" value="<{$smarty.const._MD_XOONIPS_SHOW_USER_TITLE}>" onclick="location='showusers.php?uid=<{$user_uid}>'" />
    <input class="formButton" type="button" value="<{$lang_editprofile}>" onclick="location='edituser.php'" />
    <input class="formButton" type="button" value="<{$smarty.const._MD_XOONIPS_EDIT_CV_TITLE}>" onclick="location='editcvitae.php'" />
    <input class="formButton" type="button" value="<{$lang_avatar}>" onclick="location='edituser.php?op=avatarform'" />
    <{if $user_candelete == true}>
    <input class="formButton" type="button" value="<{$lang_deleteaccount}>" onclick="location='user.php?op=delete_confirm'" />
    <{/if}>

    <input class="formButton" type="button" value="<{$lang_logout}>" onclick="location='user.php?op=logout'" /></td>
  </tr>
</table>
</form>

<br><br>
<{elseif $xoops_isadmin != false}>

<br><br>

<table width="70%" align="center" border="0">
  <tr align="center">
    <td><input class="formButton" type="button" value="<{$lang_editprofile}>" onclick="location='<{$xoops_url}>/modules/xoonips/admin/maintenance.php?page=account&amp;action=modify&amp;uid=<{$user_uid}>'" />
<{*
    <input class="formButton" type="button" value="<{$lang_deleteaccount}>" onclick="location='<{$xoops_url}>/modules/xoonips/admin/maintenance.php?page=account&amp;action=dconfirm&amp;uid=<{$user_uid}>'" />
*}>
    </td>
  </tr>
</table>

<br><br>
<{/if}>

<table width="100%" border="0" cellspacing="5">
  <tr style="vertical-align: top;">
    <td width="50%">
      <table class="outer" cellpadding="4" cellspacing="1" width="100%">
        <tr>
          <th colspan="2" align="center"><{$lang_allaboutuser}></th>
        </tr>
        <tr style="vertical-align: top;">
          <td class="head"><{$lang_avatar}></td>
          <td align="center" class="even"><img src="<{$user_avatarurl}>" alt="Avatar" /></td>
        </tr>
        <tr>
          <td class="head"><{$lang_realname}></td>
          <td align="center" class="odd"><{$user_realname}></td>
        </tr>
        <tr>
          <td class="head"><{$lang_website}></td>
          <td class="even"><{$user_websiteurl}></td>
        </tr>
        <tr style="vertical-align: top;">
          <td class="head"><{$lang_email}></td>
          <td class="odd"><{$user_email}></td>
        </tr>
	<tr style="vertical-align: top;">
          <td class="head"><{$lang_privmsg}></td>
          <td class="even"><{$user_pmlink}></td>
        </tr>
        <{* <tr style="vertical-align: top;"> *}>
          <{* <td class="head"><{$lang_icq}></td> *}>
          <{* <td class="odd"><{$user_icq}></td> *}>
        <{* </tr> *}>
        <{* <tr style="vertical-align: top;"> *}>
          <{* <td class="head"><{$lang_aim}></td> *}>
          <{* <td class="even"><{$user_aim}></td> *}>
        <{* </tr> *}>
        <{* <tr style="vertical-align: top;"> *}>
          <{* <td class="head"><{$lang_yim}></td> *}>
          <{* <td class="odd"><{$user_yim}></td> *}>
        <{* </tr> *}>
        <{* <tr style="vertical-align: top;"> *}>
          <{* <td class="head"><{$lang_msnm}></td> *}>
          <{* <td class="even"><{$user_msnm}></td> *}>
        <{* </tr> *}>
        <tr style="vertical-align: top;">
          <td class="head"><{$lang_location}></td>
          <td class="odd"><{$user_location}></td>
        </tr>
        <tr style="vertical-align: top;">
          <td class="head"><{$lang_occupation}></td>
          <td class="even"><{$user_occupation}></td>
        </tr>
        <tr style="vertical-align: top;">
          <td class="head"><{$lang_interest}></td>
          <td class="odd"><{$user_interest}></td>
        </tr>
        <tr style="vertical-align: top;">
          <td class="head"><{$lang_extrainfo}></td>
          <td class="even"><{$user_extrainfo}></td>
        </tr>
      </table>
    </td>
    <td width="50%">
      <table class="outer" cellpadding="4" cellspacing="1" width="100%">
        <tr style="vertical-align: top;">
          <th colspan="2" align="center"><{$lang_statistics}></th>
        </tr>
        <tr style="vertical-align: top;">
          <td class="head"><{$lang_membersince}></td>
          <td align="center" class="even"><{$user_joindate}></td>
        </tr>
        <tr style="vertical-align: top;">
          <td class="head"><{$lang_rank}></td>
          <td align="center" class="odd"><{$user_rankimage}><br><{$user_ranktitle}></td>
        </tr>
        <tr style="vertical-align: top;">
          <td class="head"><{$lang_posts}></td>
          <td align="center" class="even"><{$user_posts}></td>
        </tr>
	<tr style="vertical-align: top;">
          <td class="head"><{$lang_lastlogin}></td>
          <td align="center" class="odd"><{$user_lastlogin}></td>
        </tr>
      </table>
      <br>
      <table class="outer" cellpadding="4" cellspacing="1" width="100%">
        <tr style="vertical-align: top;">
          <th colspan="2" align="center"><{$lang_signature}></th>
        </tr>
        <tr style="vertical-align: top;">
          <td class="even"><{$user_signature}></td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<br>

<{if $xnp_user_ownpage == true}>
<table width="100%" border="0" cellspacing="5">
  <tr style="vertical-align: top;">
    <td width="50%">

<table class="outer" cellpadding="4" cellspacing="1" width="100%">
  <tr style="vertical-align: top;">
    <th colspan="2" align="center"><{$smarty.const._MD_XOONIPS_ACCOUNT_XNP_USER_INFO}></th>
  </tr>
  <tr style="vertical-align: top;">
    <td class="head" width="50%"><{$smarty.const._MD_XOONIPS_ACCOUNT_ADDRESS}></td>
    <td class="even" width="50%"><{$xnp_user_address}></td>
  </tr>
  <tr style="vertical-align: top;">
    <td class="head"><{$smarty.const._MD_XOONIPS_ACCOUNT_COMPANY_NAME}></td>
    <td class="odd"><{$xnp_user_company_name}></td>
  </tr>
  <tr style="vertical-align: top;">
    <td class="head"><{$smarty.const._MD_XOONIPS_ACCOUNT_DIVISION}></td>
    <td class="odd"><{$xnp_user_division}></td>
  </tr>
  <tr style="vertical-align: top;">
    <td class="head"><{$smarty.const._MD_XOONIPS_ACCOUNT_TEL}></td>
    <td class="even"><{$xnp_user_tel}></td>
  </tr>
  <tr style="vertical-align: top;">
    <td class="head"><{$smarty.const._MD_XOONIPS_ACCOUNT_COUNTRY}></td>
    <td class="even"><{$xnp_user_country}></td>
  </tr>
  <tr style="vertical-align: top;">
    <td class="head"><{$smarty.const._MD_XOONIPS_ACCOUNT_ZIPCODE}></td>
    <td class="odd"><{$xnp_user_zipcode}></td>
  </tr>
  <tr style="vertical-align: top;">
    <td class="head"><{$smarty.const._MD_XOONIPS_ACCOUNT_FAX}></td>
    <td class="even"><{$xnp_user_fax}></td>
  </tr>
  <tr style="vertical-align: top;">
    <td class="head"><{$smarty.const._MD_XOONIPS_ACCOUNT_NOTICE_MAIL}></td>
    <td class="odd"><{$xnp_user_notice_mail}></td>
  </tr>
  <tr style="vertical-align: top;">
    <td class="head"><{$smarty.const._MD_XOONIPS_ACCOUNT_POSITION}></td>
    <td class="even"><{$xnp_user_posi_t}></td>
  </tr>
  <tr style="vertical-align: top;">
    <td class="head"><{$smarty.const._MD_XOONIPS_ACCOUNT_APPEAL}></td>
    <td class="odd"><{$xnp_user_appeal}></td>
  </tr>
</table>
    </td>
    <td width="50%">
<table class="outer" cellpadding="4" cellspacing="1" width="100%">
  <tr style="vertical-align: top;">
    <th colspan="2" align="center"><{$smarty.const._MD_XOONIPS_ACCOUNT_CVITAE}></th>
  </tr>
    <{foreach from=$cv_array item=cvdata}>
  <tr>
      <td class="head"><{$cvdata.cvitae_from_month}><{$cvdata.cvitae_from_year}>
          <{if $cvdata.cvitae_from_month == '' && $cvdata.cvitae_from_year == '' && $cvdata.cvitae_to_month == '' && $cvdata.cvitae_to_year == '' }>&nbsp;<{else}>-<{/if}>
          <{$cvdata.cvitae_to_month}><{$cvdata.cvitae_to_year}></td>
      <td class="<{cycle values="even,odd"}>"><{$cvdata.cvitae_title}></td>
  </tr>
    <{/foreach}>
</table>

    </td>
  </tr>
</table>

<{/if}>

<!-- start module search results loop -->
<{foreach item=module from=$modules}>

<p>
<h4><{$module.name}></h4>

  <!-- start results item loop -->
  <{foreach item=result from=$module.results}>

  <img src="<{$result.image}>" alt="<{$module.name}>" /><string><a href="<{$result.link}>"><{$result.title}></a></string><br><small>(<{$result.time}>)</small><br>

  <{/foreach}>
  <!-- end results item loop -->

<{$module.showall_link}>
</p>

<{/foreach}>
<!-- end module search results loop -->
