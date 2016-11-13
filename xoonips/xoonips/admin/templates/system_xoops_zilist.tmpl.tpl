<patTemplate:tmpl name="main">
<patTemplate:tmpl name="header_include" src="adminheader.tmpl.tpl" parse="on"/>
<patTemplate:tmpl name="javascript" whitespace="">
<script type="text/javascript">
<!--//
function xoonips_admin_system_xoops_zilist_tuid( tuid ) {
  var url = '{MYPAGE_URL}&action=zilist&uid={UID}&tuid=' + tuid;
  self.location = url;
}
//--></script>
</patTemplate:tmpl>

<h4 style="margin-top: 20px; margin-bottom: 10px;">{LABEL_FROM} : {UNAME} ({LABEL_UID}:{UID})</h4>

<div style="margin-left: 20px; margin-bottom: 5px;">
<table width="100%" cellspacing="1" class="outer">
  <tbody>
  <tr>
    <th style="width:10%; text-align:center;">{LABEL_ITEM_ID}</th>
    <th style="width:20%; text-align:center;">{LABEL_ITEM_TYPE}</th>
    <th style="width:70%; text-align:center;">{LABEL_ITEM_TITLE}</th>
  </tr>
  <patTemplate:tmpl name="items">
  <tr>
    <td style="width:10%;" class="{EVENODD}">{ITEM_ID}</td>
    <td style="width:20%;" class="{EVENODD}">{ITEM_TYPE}</td>
    <td style="width:70%;" class="{EVENODD}"><a href="{ITEM_URL}" target="_blank">{ITEM_TITLE}</a></td>
  </tr>
  </patTemplate:tmpl>
  </tbody>
</table>

</div>

<h4 style="margin-top: 20px; margin-bottom: 10px;">{LABEL_TO} :</h4>

<div style="margin-left: 20px; margin-bottom: 5px;">
<form name="handover" action="system.php?page=xoops" method="post">
<input name="action" value="zirescue" type="hidden"/>
<input name="uid" value="{UID}" type="hidden"/>
{TOKEN_TICKET}

<select name="tuid" onchange="xoonips_admin_system_xoops_zilist_tuid(this.value);">
<patTemplate:tmpl name="to_users" type="Condition" conditionvar="SELECTED">
  <patTemplate:sub condition="1">
  <option value="{UID}" selected="selected">{UNAME}</option>
  </patTemplate:sub>
  <patTemplate:sub condition="default">
  <option value="{UID}">{UNAME}</option>
  </patTemplate:sub>
</patTemplate:tmpl>
</select>
&nbsp;&nbsp;
<select name="txid">
<patTemplate:tmpl name="to_indexes" type="Condition" conditionvar="ITEM_COUNT">
  <patTemplate:sub condition="0">
  <option value="{INDEX_ID}">{INDENT_HTML}{INDEX_TITLE}</option>
  </patTemplate:sub>
  <patTemplate:sub condition="default">
  <option value="{INDEX_ID}">{INDENT_HTML}{INDEX_TITLE}({ITEM_COUNT})</option>
  </patTemplate:sub>
</patTemplate:tmpl>
</select>

<div style="text-align: center;">
<input name="submit" value="{LABEL_EXECUTE}" type="submit" />
</div>

</form>
</div>

<patTemplate:tmpl name="footer_include" src="adminfooter.tmpl.tpl" parse="on"/>
</patTemplate:tmpl>
