<patTemplate:tmpl name="main">
<patTemplate:tmpl name="header_include" src="adminheader.tmpl.tpl" parse="on"/>
<form id="xoonips_admin_maintenance_account_form" name="xoonips_admin_maintenance_account_form" action="maintenance.php?page=account" method="post">
<input id="xoonips_admin_maintenance_account_action" name="action" value="default" type="hidden"/>
<input id="xoonips_admin_maintenance_account_uid" name="uid" value="" type="hidden"/>
<div style="text-align:right; margin-left: 10px; margin-bottom: 15px;">
  <span style="border: 1px solid #EEEEFF;border-right-color: #666699;border-bottom-color: #666699;padding: 5px; background-color: #EEEEEE; vertical-align: top;">
    <span style="font-weight: bold; color: red;">&raquo;</span>&nbsp;&nbsp;
    <a href="maintenance.php?page=account&amp;action=add">{ADD_TITLE}</a>
  </span>
</div>
<patTemplate:tmpl name="page_navi_title">
  <div style="text-align: right;">{NAVI_TITLE}</div>
</patTemplate:tmpl>
<table width="100%" cellspacing="1" class="outer">
  <tbody>
  <tr>
    <th style="width: 5%; text-align: center;">{UID}</th>
    <th style="width: 20%; text-align: left;">{UNAME}</th>
    <th style="width: 30%; text-align: left;">{NAME}</th>
    <th style="width: 35%; text-align: left;">{EMAIL}</th>
    <th style="width: 10%; text-align: center;">{ACTION}</th>
  </tr>
  <patTemplate:tmpl name="users">
  <tr>
    <td class="{EVENODD}" style="width: 5%; text-align: center;">{UID}</td>
    <td class="{EVENODD}" style="width: 20%; text-align: left;">{UNAME}</td>
    <td class="{EVENODD}" style="width: 30%; text-align: left;">{NAME}</td>
    <td class="{EVENODD}" style="width: 35%; text-align: left;">{EMAIL}</td>
    <td class="{EVENODD}" style="width: 10%; text-align: center;">
      <a href="maintenance.php?page=account&amp;action=modify&amp;uid={UID}"><img src="../images/icon_modify.png" alt="{MODIFY}" title="{MODIFY}"/></a>
      &nbsp;&nbsp;
      <a href="maintenance.php?page=account&amp;action=dconfirm&amp;uid={UID}"><img src="../images/icon_delete.png" alt="{DELETE}" title="{DELETE}"/></a>
    </td>
  </tr>
  </patTemplate:tmpl>
  <patTemplate:tmpl name="users_empty" visibility="hidden">
  <tr>
    <td class="odd" colspan="4" style="text-align: center;">
      <span style="color: red; font-weight: bold;">{EMPTY}</span>
    </td>
  </tr>
  </patTemplate:tmpl>
  </tbody>
</table>
</form>
<br>
<patTemplate:tmpl name="page_navi_include" src="adminpagenavi.tmpl.tpl" parse="on"/>
<patTemplate:tmpl name="footer_include" src="adminfooter.tmpl.tpl" parse="on"/>
</patTemplate:tmpl>
