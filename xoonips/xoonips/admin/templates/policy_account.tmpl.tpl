<patTemplate:tmpl name="main">
<patTemplate:tmpl name="header_include" src="adminheader.tmpl.tpl" parse="on"/>
<form name="xoonips_admin_policy_account_register" action="policy.php?page=account" method="post">
<input name="action" value="rupdate" type="hidden"/>
{TOKEN_TICKET}
<table width="100%" cellspacing="1" class="outer">
  <tbody>
  <tr>
    <th colspan="2">{REGISTER_USER_TITLE}</th>
  </tr>
  <tr>
    <td class="head" style="width: 40%; vertical-align: top;">
      <span style="font-weight: bold;">{ACTIVATE_USER_TITLE}</span>
      <br><br>
      <span style="font-weight: normal;">{ACTIVATE_USER_DESC}</span>
    </td>
    <td class="even" style="width: 60%; vertical-align: top;">
      <select name="activate_user" size="1">
      <patTemplate:tmpl name="activate_user" type="Condition" conditionvar="SELECTED">
        <patTemplate:sub condition="yes">
          <option value="{VALUE}" selected="selected">{LABEL}</option>
        </patTemplate:sub>
        <patTemplate:sub condition="no">
          <option value="{VALUE}">{LABEL}</option>
        </patTemplate:sub>
      </patTemplate:tmpl>
      </select>
    </td>
  </tr>
  <tr>
    <td class="head" style="width: 40%; vertical-align: top;">
      <span style="font-weight: bold;">{CERTIFY_USER_TITLE}</span>
      <br><br>
      <span style="font-weight: normal;">{CERTIFY_USER_DESC}</span>
    </td>
    <td class="even" style="width: 60%; vertical-align: top;">
      <select name="certify_user" size="1">
      <patTemplate:tmpl name="certify_user" type="Condition" conditionvar="SELECTED">
        <patTemplate:sub condition="yes">
          <option value="{VALUE}" selected="selected">{LABEL}</option>
        </patTemplate:sub>
        <patTemplate:sub condition="no">
          <option value="{VALUE}">{LABEL}</option>
        </patTemplate:sub>
      </patTemplate:tmpl>
      </select>
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
<br>
<form name="xoonips_admin_policy_account_info" action="policy.php?page=account" method="post">
<input name="action" value="iupdate" type="hidden"/>
{TOKEN_TICKET}
<table width="100%" cellspacing="1" class="outer">
  <tbody>
  <tr>
    <th colspan="2">{INFO_REQUIREMENT_TITLE}</th>
  </tr>
  <patTemplate:tmpl name="info_requirement" type="Condition" conditionvar="CHECKED">
    <patTemplate:sub condition="yes">
    <tr>
      <td class="head" style="width: 40%; vertical-align: top;">
        <span style="font-weight: bold;">{TITLE}</span>
      </td>
      <td class="even" style="width: 60%; vertical-align: top;">
        <input name="{NAME}" type="radio" value="on" checked="checked"/>{OPTIONAL}&nbsp;
        <input name="{NAME}" type="radio" value="off"/>{REQUIRE}
      </td>
    </tr>
    </patTemplate:sub>
    <patTemplate:sub condition="no">
    <tr>
      <td class="head" style="width: 40%; vertical-align: top;">
        <span style="font-weight: bold;">{TITLE}</span>
      </td>
      <td class="even" style="width: 60%; vertical-align: top;">
        <input name="{NAME}" type="radio" value="on"/>{OPTIONAL}&nbsp;
        <input name="{NAME}" type="radio" value="off" checked="checked"/>{REQUIRE}
      </td>
    </tr>
    </patTemplate:sub>
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
<br>
<form name="xoonips_admin_policy_account_initvals" action="policy.php?page=account" method="post">
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
