<patTemplate:tmpl name="main">
<patTemplate:tmpl name="header_include" src="adminheader.tmpl.tpl" parse="on"/>
<form name="xoonips_admin_system_print" action="system.php?page=print" method="post">
<input name="action" value="update" type="hidden"/>
{TOKEN_TICKET}
<table width="100%" cellspacing="1" class="outer">
  <tbody>
  <tr>
    <th colspan="2">{TITLE}</th>
  </tr>
  <tr>
    <td class="head" style="width: 40%; vertical-align: top;">
      <span style="font-weight: bold;">{PRINTER_FRIENDLY_HEADER_TITLE}</span>
      <br><br>
      <span style="font-weight: normal;">{PRINTER_FRIENDLY_HEADER_DESC}</span>
    </td>
    <td class="even" style="width: 60%; vertical-align: top;">
      <textarea name="printer_friendly_header" rows="5" cols="40">{PRINTER_FRIENDLY_HEADER}</textarea>
    </td>
  </tr>
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
