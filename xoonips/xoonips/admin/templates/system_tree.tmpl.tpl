<patTemplate:tmpl name="main">
<patTemplate:tmpl name="header_include" src="adminheader.tmpl.tpl" parse="on"/>
<form name="xoonips_admin_system_tree" action="system.php?page=tree" method="post">
<input name="action" value="update" type="hidden"/>
{TOKEN_TICKET}
<table width="100%" cellspacing="1" class="outer">
  <tbody>
  <tr>
    <th colspan="2">{TITLE}</th>
  </tr>
  <tr>
    <td class="head" style="width: 40%; vertical-align: top;">
      <span style="font-weight: bold;">{TREE_FRAME_WIDTH_TITLE}</span>
      <br><br>
      <span style="font-weight: normal;">{TREE_FRAME_WIDTH_DESC}</span>
    </td>
    <td class="even" style="width: 60%; vertical-align: top;">
      <input name="tree_frame_width" type="text" size="10" value="{TREE_FRAME_WIDTH}"/>
    </td>
  </tr>
  <tr>
    <td class="head" style="width: 40%; vertical-align: top;">
      <span style="font-weight: bold;">{TREE_FRAME_HEIGHT_TITLE}</span>
      <br><br>
      <span style="font-weight: normal;">{TREE_FRAME_HEIGHT_DESC}</span>
    </td>
    <td class="even" style="width: 60%; vertical-align: top;">
      <input name="tree_frame_height" type="text" size="10" value="{TREE_FRAME_HEIGHT}"/>
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
