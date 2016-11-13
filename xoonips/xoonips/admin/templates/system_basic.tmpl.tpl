<patTemplate:tmpl name="main">
<patTemplate:tmpl name="header_include" src="adminheader.tmpl.tpl" parse="on"/>
<form name="xoonips_admin_system_basic" action="system.php?page=basic" method="post">
<input name="action" value="update" type="hidden"/>
{TOKEN_TICKET}
<table width="100%" cellspacing="1" class="outer">
  <tbody>
  <tr>
    <th colspan="2">{TITLE}</th>
  </tr>
  <tr>
    <td class="head" style="width: 40%; vertical-align: top;">
      <span style="font-weight: bold;">{MODERATOR_GID_TITLE}</span>
      <br><br>
      <span style="font-weight: normal;">{MODERATOR_GID_DESC}</span>
    </td>
    <td class="even" style="width: 60%; vertical-align: top;">
      <select name="moderator_gid" size="1">
      <patTemplate:tmpl name="moderator_gid" type="Condition" conditionvar="SELECTED">
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
      <span style="font-weight: bold;">{UPLOAD_DIR_TITLE}</span>
      <br><br>
      <span style="font-weight: normal;">{UPLOAD_DIR_DESC}</span>
    </td>
    <td class="even" style="width: 60%; vertical-align: top;">
      <input name="upload_dir" type="text" size="50" value="{UPLOAD_DIR}"/>
    </td>
  </tr>
  <tr>
    <td class="head" style="width: 40%; vertical-align: top;">
      <span style="font-weight: bold;">{MAGIC_FILE_PATH_TITLE}</span>
      <br><br>
      <span style="font-weight: normal;">{MAGIC_FILE_PATH_DESC}</span>
    </td>
    <td class="even" style="width: 60%; vertical-align: top;">
      <input name="magic_file_path" type="text" size="50" value="{MAGIC_FILE_PATH}"/>
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
