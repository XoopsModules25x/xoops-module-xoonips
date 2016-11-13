<patTemplate:tmpl name="main">
<patTemplate:tmpl name="header_include" src="adminheader.tmpl.tpl" parse="on"/>
<patTemplate:tmpl name="submit_javascript" whitespace="">
<script type="text/javascript">
<!--//
// 
// If no options are selected, show alert and require to select options.
// If options are selected, make confirmation for index select
// 
// @return true if accepted.
// 
function xoonips_admin_maintenance_item_idxselect_confirm() {
  var prefix = 'xoonips_admin_maintenance_item_idxselect';
  var tree = document.getElementById( prefix + '_tree' );
  var action = document.getElementById( prefix + '_action' );
  var options = tree.options;
  for ( i = 0; i < options.length; i++ ) {
    if ( options[i].selected ) {
      //at least one option is selected
      ret = confirm( '{CONFIRM_DESC}' + '\n' + '{CONFIRM}' );
      if ( ret ) {
        action.value = '{ACTION}';
      }
      return ret;
    }
  }
  alert( '{SELECT_INDEX}' );
  return false;
}
//--></script>
</patTemplate:tmpl>
<form action="maintenance.php?page=item" method="post" onsubmit="return xoonips_admin_maintenance_item_idxselect_confirm();">
  <input id="xoonips_admin_maintenance_item_idxselect_action" name="action" value="default" type="hidden"/>
  {TOKEN_TICKET}
  <select id='xoonips_admin_maintenance_item_idxselect_tree' name="tree[]" size="25" multiple="multiple">
    <patTemplate:tmpl name="treelist">
    <option value="{ID}">{FULLPATH}</option>
    </patTemplate:tmpl>
  </select>
  <div style="margin-top: 15px;">
    <patTemplate:tmpl name="back" visibility="hidden">
    <input type="button" value="{BACK}" onclick="history.go(-1);"/>
    &nbsp;&nbsp;
    </patTemplate:tmpl>
    <input type="submit" value="{SUBMIT}"/>
  </div>
</form>
<patTemplate:tmpl name="footer_include" src="adminfooter.tmpl.tpl" parse="on"/>
</patTemplate:tmpl>
