<patTemplate:tmpl name="main">
<patTemplate:tmpl name="header_include" src="adminheader.tmpl.tpl" parse="on"/>
<form name="xoonips_admin_system_check" action="system.php?page=check" method="post">
<input name="action" value="test" type="hidden"/>
<patTemplate:tmpl name="results_table" visibility="hidden">
<table width="100%" cellspacing="1" class="outer">
  <tbody>
  <tr>
    <th colspan="2">{TITLE}</th>
  </tr>
  <patTemplate:tmpl name="results">
  <tr>
    <td class="head" style="width: 20%; vertical-align: top;">
      {NAME}
    </td>
    <td class="even" style="width: 80%; vertical-align: top;">
      {RESULT}
    </td>
  </tr>
  </patTemplate:tmpl>
  <tr>
    <td class="head" style="width: 20%; vertical-align: top;">&nbsp;</td>
    <td class="even" style="width: 80%; vertical-align: top;">
      <input name="recheck" type="submit" value="{RECHECK}"/>
    </td>
  </tr>
  </tbody>
</table>
</patTemplate:tmpl>
<patTemplate:tmpl name="first">
<input name="check" value="{CHECK}" type="submit"/>
</patTemplate:tmpl>
</form>
<patTemplate:tmpl name="footer_include" src="adminfooter.tmpl.tpl" parse="on"/>
</patTemplate:tmpl>
