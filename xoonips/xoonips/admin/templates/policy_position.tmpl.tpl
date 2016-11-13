<patTemplate:tmpl name="main">
<patTemplate:tmpl name="header_include" src="adminheader.tmpl.tpl" parse="on"/>
<patTemplate:tmpl name="delete_javascript" whitespace="">
<script type="text/javascript">
<!--//
function xoonips_admin_policy_position_delete( id, title ) {
  /* confirmation */
  var myret = confirm( '{DELETE_CONFIRM}' + '\n\n' + '{POSITION} : ' + title );
  if ( myret == false ) {
    return false;
  }
  /* delete */
  var prefix = 'xoonips_admin_policy_position_list';
  var form = document.getElementById( prefix + '_form' );
  var action = document.getElementById( prefix + '_action' );
  var delete_id = document.getElementById( prefix + '_delete_id' );
  action.value = 'delete';
  delete_id.value = id;
  form.delete_id.value = id;
  form.submit();
  return false;
}
//--></script>
</patTemplate:tmpl>
<h4 style="margin-top: 20px; margin-bottom: 10px;">&raquo;&nbsp;{LIST_TITLE}</h4>
<form name="xoonips_admin_policy_position_list_form" id="xoonips_admin_policy_position_list_form" action="policy.php?page=position" method="post">
<input name="action" id="xoonips_admin_policy_position_list_action" value="update" type="hidden"/>
<input name="delete_id" id="xoonips_admin_policy_position_list_delete_id" value="" type="hidden"/>
{TOKEN_TICKET}
<table width="100%" cellspacing="1" class="outer">
  <tbody>
  <tr>
    <th style="width: 75%; text-align: left;">{POSITION}</th>
    <th style="width: 15%; text-align: center;">{WEIGHT}</th>
    <th style="width: 10%; text-align: center;">{ACTION}</th>
  </tr>
  <patTemplate:tmpl name="position_list">
  <tr>
    <td class="{EVENODD}" style="text-align: left;">
      {TITLE_S}<br>
      <input type="text" name="title[{ID}]" value="{TITLE_E}" size="50" maxlength="50"/>
    </td>
    <td class="{EVENODD}" style="text-align: center;">
      <input type="text" name="order[{ID}]" value="{ORDER}" size="5" maxlength="5" style="text-align: right;"/>
    </td>
    <td class="{EVENODD}" style="text-align: center;">
      <a href="#" onclick="return xoonips_admin_policy_position_delete('{ID}', '{TITLE_JS}');"><img src="../images/icon_delete.png" alt="{DELETE}" title="{DELETE}"/></a>
    </td>
  </tr>
  </patTemplate:tmpl>
  <patTemplate:tmpl name="position_list_submit">
  <tr>
    <td class="head" colspan="3" style="text-align: center;">
      <input name="submit_update" type="submit" value="{SUBMIT}"/>
    </td>
  </tr>
  </patTemplate:tmpl>
  <patTemplate:tmpl name="position_list_empty" visibility="hidden">
    <tr>
      <td class="odd" colspan="3" style="text-align: center; font-weight: bold; color: red;">{EMPTY}</td>
    </tr>
  </patTemplate:tmpl>
  </tbody>
</table>
</form>
<br>
<h4 style="margin-top: 20px; margin-bottom: 10px;">&raquo;&nbsp;{ADD_TITLE}</h4>
<form name="xoonips_admin_policy_position_add_form" action="policy.php?page=position" method="post">
<input name="action" value="add" type="hidden"/>
{TOKEN_TICKET}
<table width="100%" cellspacing="1" class="outer">
  <tbody>
  <tr>
    <th style="width: 85%; text-align: left;">{POSITION}</th>
    <th style="width: 15%; text-align: center;">{WEIGHT}</th>
  </tr>
  <tr>
    <td class="even" style="text-align: left;">
      <input type="text" name="title" value="" size="50" maxlength="50"/>
    </td>
    <td class="even" style="text-align: center;">
      <input type="text" name="order" value="0" size="5" maxlength="5" style="text-align: right;"/>
    </td>
  </tr>
  <tr>
    <td class="head" colspan="2" style="text-align: center;">
      <input name="submit_update" type="submit" value="{SUBMIT}"/>
    </td>
  </tr>
  </tbody>
</table>
</form>
<patTemplate:tmpl name="footer_include" src="adminfooter.tmpl.tpl" parse="on"/>
</patTemplate:tmpl>
