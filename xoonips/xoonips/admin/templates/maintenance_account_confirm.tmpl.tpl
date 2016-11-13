<patTemplate:tmpl name="main">
<patTemplate:tmpl name="header_include" src="adminheader.tmpl.tpl" parse="on"/>
<h4 style="margin: 3px; text-align: center; color: red;">{CONFIRM_MSG}</h4>
<form action="maintenance.php?page=account" method="post">
<input name="action" value="{ACTION}" type="hidden"/>
<input name="uid" value="{UID_VALUE}" type="hidden"/>
{TOKEN_TICKET}
<table width="100%" cellspacing="1" class="outer">
  <tbody>
  <tr>
    <th style="width: 5%; text-align: center;">{UID_TITLE}</th>
    <th style="width: 20%; text-align: left;">{UNAME_TITLE}</th>
    <th style="width: 35%; text-align: left;">{NAME_TITLE}</th>
    <th style="width: 40%; text-align: left;">{EMAIL_TITLE}</th>
  </tr>
  <tr>
    <td class="odd" style="width: 5%; text-align: center;">{UID_VALUE}</td>
    <td class="odd" style="width: 20%; text-align: left;">{UNAME_VALUE}</td>
    <td class="odd" style="width: 35%; text-align: left;">{NAME_VALUE}</td>
    <td class="odd" style="width: 40%; text-align: left;">{EMAIL_VALUE}</td>
  </tr>
  <tr>
    <td class="head" colspan="4" style="text-align: center;">
      <input name="confirm_back" value="{NO}" onclick="history.go(-1);" type="button"/>
      <patTemplate:tmpl name="submit">
      &nbsp;&nbsp;
      <input name="confirm_submit" value="{YES}" type="submit"/>
      </patTemplate:tmpl>
    </td>
  </tr>
  </tbody>
</table>
</form>
<patTemplate:tmpl name="footer_include" src="adminfooter.tmpl.tpl" parse="on"/>
</patTemplate:tmpl>
