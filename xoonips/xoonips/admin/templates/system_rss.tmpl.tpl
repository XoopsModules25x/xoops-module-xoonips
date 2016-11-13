<patTemplate:tmpl name="main">
<patTemplate:tmpl name="header_include" src="adminheader.tmpl.tpl" parse="on"/>
<patTemplate:tmpl name="focus_javascript" whitespace="">
<script type="text/javascript">
<!--//
function xoonips_admin_feed_url_focus( name ) {
  var prefix = 'xoonips_admin_system_rss_';
  var el_form = document.getElementById( prefix + 'form' );
  var el_url = document.getElementById( prefix + name );
  el_form.focus();
  el_url.select();
}
//--></script>
</patTemplate:tmpl>
<form id="xoonips_admin_system_rss_form" name="xoonips_admin_system_rss_form" action="system.php?page=rss" method="post">
<input name="action" value="update" type="hidden"/>
{TOKEN_TICKET}
<table width="100%" cellspacing="1" class="outer">
  <tbody>
  <tr>
    <th>{FEED_URL_TITLE}</th>
  </tr>
  <tr>
    <td class="even" style="width: 60%; vertical-align: top;">
      <div style="font-weight: normal;">{FEED_URL_DESC}</div>
      <div style="margin: 10px;">
      <a href="{FEED_URL_RDF}" target="_blank"><img style="vertical-align: bottom;" src="../images/feed.png" alt="RSS 1.0"/></a>&nbsp;
      <span style="font-weight: bold;"><a href="javascript:void(0);" onclick="xoonips_admin_feed_url_focus('rdf');">RSS 1.0</a></span>
      <br>
      <input style="margin-left: 20px;" id="xoonips_admin_system_rss_rdf" type="text" size="80" readonly="readonly" onclick="xoonips_admin_feed_url_focus('rdf');" value="{FEED_URL_RDF}"/>
      <br><br>
      <a href="{FEED_URL_RSS}" target="_blank"><img style="vertical-align: bottom;" src="../images/feed.png" alt="RSS 2.0"/></a>&nbsp;
      <span style="font-weight: bold;"><a href="javascript:void(0);" onclick="xoonips_admin_feed_url_focus('rss');">RSS 2.0</a></span>
      <br>
      <input style="margin-left: 20px;" id="xoonips_admin_system_rss_rss" type="text" size="80" readonly="readonly" onclick="xoonips_admin_feed_url_focus('rss');" value="{FEED_URL_RSS}"/>
      <br><br>
      <a href="{FEED_URL_ATOM}" target="_blank"><img style="vertical-align: bottom;" src="../images/feed.png" alt="Atom 1.0"/></a>&nbsp;
      <span style="font-weight: bold;"><a href="javascript:void(0);" onclick="xoonips_admin_feed_url_focus('atom');">Atom 1.0</a></span>
      <br>
      <input style="margin-left: 20px;" id="xoonips_admin_system_rss_atom" type="text" size="80" readonly="readonly" onclick="xoonips_admin_feed_url_focus('atom');" value="{FEED_URL_ATOM}"/>
      </div>
      <div style="margin:10px;">
      <span style="font-weight: bold;"><a href="javascript:void(0);" onclick="xoonips_admin_feed_url_focus('html');">Sample HTML &lt;link&gt; tags</a></span>
      <br>
      <textarea style="margin-left: 20px; width: 500px;" wrap="off" id="xoonips_admin_system_rss_html" rows="3" cols="50" readonly="readonly" onclick="xoonips_admin_feed_url_focus('html');">{FEED_URL_HTML}</textarea>
      </div>
    </td>
  </tr>
  </tbody>
</table>
<br><br>
<table width="100%" cellspacing="1" class="outer">
  <tbody>
  <tr>
    <th colspan="2">{TITLE}</th>
  </tr>
  <tr>
    <td class="head" style="width: 40%; vertical-align: top;">
      <span style="font-weight: bold;">{FEED_ITEM_MAX_TITLE}</span>
      <br><br>
      <span style="font-weight: normal;">{FEED_ITEM_MAX_DESC}</span>
    </td>
    <td class="even" style="width: 60%; vertical-align: top;">
      <input name="rss_item_max" type="text" size="3" maxlength="3" value="{FEED_ITEM_MAX}"/>
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
