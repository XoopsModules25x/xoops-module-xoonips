<patTemplate:tmpl name="main">
<patTemplate:tmpl name="header_include" src="adminheader.tmpl.tpl" parse="on"/>
<form name="xoonips_admin_policy_item_comment" action="policy.php?page=item" method="post">
<input name="action" value="compmupdate" type="hidden"/>
{TOKEN_TICKET}
<table width="100%" cellspacing="1" class="outer">
  <tbody>
  <tr>
    <th colspan="2">{COMMENT_TITLE}</th>
  </tr>
  <!-- d3forum directory name -->
  <tr>
    <td class="head" style="width: 40%; vertical-align: top;">
      <span style="font-weight: bold;">{D3FORUM_DIRNAME_TITLE}</span>
      <br><br>
      <span style="font-weight: normal;">{D3FORUM_DIRNAME_DESC}</span>
    </td>
    <td class="even" style="width: 60%; vertical-align: top;">
      <select name="item_comment_dirname" size="1">
      <patTemplate:tmpl name="d3forums" type="Condition" conditionvar="SELECTED">
        <patTemplate:sub condition="1">
        <option value="{DIRNAME}" selected="selected">{LABEL}</option>
        </patTemplate:sub>
        <patTemplate:sub condition="default">
        <option value="{DIRNAME}">{LABEL}</option>
        </patTemplate:sub>
      </patTemplate:tmpl>
      </select>
      <br>
      <span style="color:red; font-weight:bold;">{D3FORUM_DIRNAME_NOTFOUND}</span>
    </td>
  </tr>
  <!-- d3forum forum id -->
  <tr>
    <td class="head" style="width: 40%; vertical-align: top;">
      <span style="font-weight: bold;">{D3FORUM_FORUMID_TITLE}</span>
      <br><br>
      <span style="font-weight: normal;">{D3FORUM_FORUMID_DESC}</span>
    </td>
    <td class="even" style="width: 60%; vertical-align: top;">
      <input name="item_comment_forum_id" type="text" value="{D3FORUM_FORUMID}" size="7" maxlength="10"/>
      <br>
      <span style="color:red; font-weight:bold;">{D3FORUM_FORUMID_NOTFOUND}</span>
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
