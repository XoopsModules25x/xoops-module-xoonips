<patTemplate:tmpl name="main">
<patTemplate:tmpl name="header_include" src="adminheader.tmpl.tpl" parse="on"/>
<form name="xoonips_admin_system_proxy" action="system.php?page=proxy" method="post">
<input name="action" value="update" type="hidden"/>
{TOKEN_TICKET}
<table width="100%" cellspacing="1" class="outer">
  <tbody>
  <tr>
    <th colspan="2">{TITLE}</th>
  </tr>
  <tr>
    <td class="head" style="width: 40%; vertical-align: top;">
      <span style="font-weight: bold;">{PROXY_HOST_TITLE}</span>
      <br><br>
      <span style="font-weight: normal;">{PROXY_HOST_DESC}</span>
    </td>
    <td class="even" style="width: 60%; vertical-align: top;">
      <input name="proxy_host" type="text" size="50" value="{PROXY_HOST}"/>
    </td>
  </tr>
  <tr>
    <td class="head" style="width: 40%; vertical-align: top;">
      <span style="font-weight: bold;">{PROXY_PORT_TITLE}</span>
      <br><br>
      <span style="font-weight: normal;">{PROXY_PORT_DESC}</span>
    </td>
    <td class="even" style="width: 60%; vertical-align: top;">
      <input name="proxy_port" type="text" size="5" maxlength="5" value="{PROXY_PORT}"/>
    </td>
  </tr>
  <tr>
    <td class="head" style="width: 40%; vertical-align: top;">
      <span style="font-weight: bold;">{PROXY_USER_TITLE}</span>
      <br><br>
      <span style="font-weight: normal;">{PROXY_USER_DESC}</span>
    </td>
    <td class="even" style="width: 60%; vertical-align: top;">
      <input name="proxy_user" type="text" size="20" value="{PROXY_USER}"/>
    </td>
  </tr>
  <tr>
    <td class="head" style="width: 40%; vertical-align: top;">
      <span style="font-weight: bold;">{PROXY_PASS_TITLE}</span>
      <br><br>
      <span style="font-weight: normal;">{PROXY_PASS_DESC}</span>
    </td>
    <td class="even" style="width: 60%; vertical-align: top;">
      <input name="proxy_pass" type="password" size="20" value="{PROXY_PASS}"/>
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
