<patTemplate:tmpl name="main">
<patTemplate:tmpl name="header_include" src="adminheader.tmpl.tpl" parse="on"/>
<form action="maintenance.php" method="get">
  <input name="page" value="item" type="hidden"/>
  <input name="action" value="{NEXTACTION}" type="hidden"/>
  <select name="uid" size="1">
    <patTemplate:tmpl name="userlist">
    <option value="{UID}" {SELECTED}>{UNAME}</option>
    </patTemplate:tmpl>
  </select>
  <div style="margin-top: 15px;">
    <input type="submit" value="{SUBMIT}"/>
  </div>
</form>
<patTemplate:tmpl name="footer_include" src="adminfooter.tmpl.tpl" parse="on"/>
</patTemplate:tmpl>
