<patTemplate:tmpl name="main">
<patTemplate:tmpl name="header_include" src="adminheader.tmpl.tpl" parse="on"/>
<form name="xoonips_admin_policy_group_initvals" action="policy.php?page=group" method="post">
<input name="action" value="vupdate" type="hidden"/>
{TOKEN_TICKET}
<table width="100%" cellspacing="1" class="outer">
  <tbody>
  <tr>
    <th colspan="2">{INITIAL_VALUES_TITLE}</th>
  </tr>
  <patTemplate:tmpl name="initial_values">
  <tr>
    <td class="head" style="width: 40%; vertical-align: top;">
      <span style="font-weight: bold;">{TITLE}</span>
      <br><br>
      <span style="font-weight: normal;">{DESC}</span>
    </td>
    <td class="even" style="width: 60%; vertical-align: top;">
      <input name="{NAME}" type="text" value="{VALUE}" size="7" maxlength="7"/>
    </td>
  </tr>
  </patTemplate:tmpl>
  <tr>
    <td class="head" style="width: 40%; vertical-align: top;">&nbsp;</td>
    <td class="even" style="width: 60%; vertical-align: top;">
      <input name="submit" type="submit" value="{SUBMIT}"/>
    </td>
  </tr>
  </tbody>
</table>
</form>
<patTemplate:tmpl name="footer_include" src="adminfooter.tmpl.tpl" parse="on"/>
</patTemplate:tmpl>
