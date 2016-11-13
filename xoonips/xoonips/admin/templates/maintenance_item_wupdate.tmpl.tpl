<patTemplate:tmpl name="main">
<patTemplate:tmpl name="header_include" src="adminheader.tmpl.tpl" parse="on"/>
<table width="100%" cellspacing="1" class="outer">
  <tbody>
  <tr>
    <th style="width: 55%; text-align: left;">{INDEX}</th>
    <th style="width: 15%; text-align: left;">{SUCCEED}</th>
    <th style="width: 15%; text-align: left;">{FAILED}</th>
    <th style="width: 15%; text-align: left;">{UNCERTIFIED}</th>
  </tr>
  <patTemplate:tmpl name="results">
  <tr>
    <td class="{EVENODD}" style="width: 55%; text-align: left;">{INDEX}</td>
    <td class="{EVENODD}" style="width: 15%; text-align: right;">{SUCCEED}</td>
    <td class="{EVENODD}" style="width: 15%; text-align: right;">{FAILED}</td>
    <td class="{EVENODD}" style="width: 15%; text-align: right;">{UNCERTIFIED}</td>
  </tr>
  </patTemplate:tmpl>
  <patTemplate:tmpl name="empty_results" visibility="hidden">
  <tr>
    <td colspan="4" class="odd" style="text-align: center;">
      <span style="color: red; font-weight: bold;">{EMPTY}</span>
    </td>
  </tr>
  </patTemplate:tmpl>
  </tbody>
</table>

<div style="margin-top: 15px;">
  &raquo;&raquo;&nbsp;<a href="maintenance.php?page=item&amp;action=withdraw">{BACK}</a>
</div>

<patTemplate:tmpl name="footer_include" src="adminfooter.tmpl.tpl" parse="on"/>
</patTemplate:tmpl>
