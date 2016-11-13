<script type="text/javascript" src="js/prototype.js">
</script>

<script type="text/javascript">
//<![CDATA[
function showDetail( identifier ){
    $('xoonips_hidden_oampmh_search_result_identifier').value=identifier;
    $('xoonips_oampmh_search_result_form').action='oaipmh_search.php?action=detail';
    $('xoonips_oampmh_search_result_form').submit();
    return false;
}
//]]>
</script>


<div class='xoonips_page_title'>
<{$smarty.const._MD_XOONIPS_OAIPMH_SEARCH_RESULT_PAGE_TITLE}>
</div>

<form id='xoonips_oampmh_search_result_form'
      action='oaipmh_search.php?action=search'
      method='post'>

  <div style='text-align: center;'>
  <table width="100%" border="0">
    <tr style="vertical-align: top;">
      <td>
       <{$smarty.const._MD_XOONIPS_OAIPMH_SEARCH_RESULT_ORDER_BY}>
       <select id='xoonips_oampmh_search_result_order_by' name="order_by" onchange="$('xoonips_oampmh_search_result_form').submit();">
        <option value="title" <{if "title"==$order_by}> selected="selected" <{/if}> ><{$smarty.const._MD_XOONIPS_OAIPMH_SEARCH_RESULT_TITLE_LABEL}></option>
        <option value="identifier"   <{if "identifier"==$order_by}> selected="selected" <{/if}> ><{$smarty.const._MD_XOONIPS_OAIPMH_SEARCH_RESULT_IDENTIFIER_LABEL}></option>
        <option value="last_update_date" <{if "last_update_date"==$order_by}> selected="selected" <{/if}> ><{$smarty.const._MD_XOONIPS_OAIPMH_SEARCH_RESULT_LAST_UPDATE_DATE_LABEL}></option>
        <option value="creation_date"    <{if "creation_date"==$order_by}> selected="selected" <{/if}> > <{$smarty.const._MD_XOONIPS_OAIPMH_SEARCH_RESULT_CREATION_DATE_LABEL}></option>
        <option value="date" <{if "date"==$order_by}> selected="selected" <{/if}> ><{$smarty.const._MD_XOONIPS_OAIPMH_SEARCH_RESULT_DATE_LABEL}></option>
       </select>
       <select id='xoonips_oampmh_search_result_order_dir' name="order_dir" onchange="$('xoonips_oampmh_search_result_form').submit();">
        <option value="asc" <{if "asc"==$order_dir}> selected="selected" <{/if}> ><{$smarty.const._MD_XOONIPS_OAIPMH_SEARCH_RESULT_ASC_LABEL}></option>
        <option value="desc"   <{if "desc"==$order_dir}> selected="selected" <{/if}> ><{$smarty.const._MD_XOONIPS_OAIPMH_SEARCH_RESULT_DESC_LABEL}></option>
       </select>
      </td>
      <td>
       <{$smarty.const._MD_XOONIPS_OAIPMH_SEARCH_RESULT_NUM_OF_METADATA_PER_PAGE}>
       <select id='xoonips_oampmh_search_result_metadata_per_page' name="metadata_per_page" onchange="$('xoonips_oampmh_search_result_form').submit();">
        <option value="20" <{if "20"==$metadata_per_page }> selected="selected" <{/if}> >20</option>
        <option value="50" <{if "50"==$metadata_per_page }> selected="selected" <{/if}> >50</option>
        <option value="100" <{if "100"==$metadata_per_page }> selected="selected" <{/if}> >100</option>
       </select>
      </td>
    </tr>
  </table> 
  </div>

<br>
<br>
  
  <div style='text-align: center;'>
  <table width="100%" border="0">
   <tr>
    <td style="text-align: left;">
      <{$start_metadata_count}> - <{$end_metadata_count}> of <{$total_metadata_count}> Items 
    </td>
    <td style="text-align: right;">
      <{if $maxpage > 1}>
        <{if $page > 1}>
        <a href="javascript:void(0);"
           onclick="$('xoonips_oampmh_search_result_page').value=<{$page-1}> $('xoonips_oampmh_search_result_form').submit(); return false;"><{$smarty.const._MD_XOONIPS_OAMPMH_SEARCH_RESULT_PAGENAVI_PREV}></a>&nbsp;
        <{else}>
          <{$smarty.const._MD_XOONIPS_OAMPMH_SEARCH_RESULT_PAGENAVI_PREV}>&nbsp;
        <{/if}>
        <{foreach item=i from=$pages}>
          <{if $i==$page}>
            <{$i}>
          <{else}>
        <a href="javascript:void(0);"
           onclick="$('xoonips_oampmh_search_result_page').value=<{$i}> $('xoonips_oampmh_search_result_form').submit(); return false;"><{$i}></a>
        <{/if}>
          &nbsp;
        <{/foreach}>
        <{if $page < $maxpage }>
        <a href="javascript:void(0);"
           onclick="$('xoonips_oampmh_search_result_page').value=<{$page+1}> $('xoonips_oampmh_search_result_form').submit(); return false;"><{$smarty.const._MD_XOONIPS_OAMPMH_SEARCH_RESULT_PAGENAVI_NEXT}></a>
        <{else}>
          <{$smarty.const._MD_XOONIPS_OAMPMH_SEARCH_RESULT_PAGENAVI_NEXT}>
        <{/if}>
      <{/if}>
    </td>
   </tr>
  </table>
  </div>

  <input id='xoonips_hidden_oampmh_search_result_identifier' type='hidden'
     name='identifier' value='' />

  <input type='hidden' name='repository_id' value='<{$repository_id}>' />
  <input type='hidden' name='keyword' value='<{$keyword}>' />
  <input type='hidden' name='search_flag' value='0' />
  <input type='hidden' name='search_cache_id' value='<{$search_cache_id}>' />
  <input id='xoonips_oampmh_search_result_page' type='hidden' name='page' value='<{$page}>' />

</form>

<form id='xoonips_oampmh_search_result_back_form1'
      action='oaipmh_search.php?action=default'
      method='post'>
  
  <input id='xoonips_oampmh_search_result_back_submit1' type='submit' value='<{$smarty.const._MD_XOONIPS_OAIPMH_SEARCH_RESULT_BACK}>' />
  <input type='hidden' name='repository_id' value='<{$repository_id}>' />
  <input type='hidden' name='keyword' value='<{$keyword}>' />
</form>


<{foreach item=i from=$metadata}>
 <table class="xoonips_metadata_search_result <{cycle name="oddeven" values="odd,even"}>">
   <tr>
     <td class='xoonips_metadata_search_result_left'><{$smarty.const._MD_XOONIPS_OAIPMH_SEARCH_RESULT_TITLE}></td>
     <td class='xoonips_metadata_search_result_right'><a id='xoonips_oaipmh_search_metadata_id_<{$i.metadata_id}>' href='javascript:void(0)' onclick='return showDetail("<{$i.id}>");'><{$i.title}></a></td>
   </tr>
   <tr>
     <td class='xoonips_metadata_search_result_left'><{$smarty.const._MD_XOONIPS_OAIPMH_SEARCH_RESULT_REPOSITORY_NAME}></td>
     <td class='xoonips_metadata_search_result_right'><{$i.repository_name}></td>
   </tr>
   <tr>
     <td class='xoonips_metadata_search_result_left'><{$smarty.const._MD_XOONIPS_OAIPMH_SEARCH_RESULT_ID}></td>
     <td class='xoonips_metadata_search_result_right'><{$i.id}></td>
   </tr>
<{if $i.last_update_date != ''}>
   <tr>
     <td class='xoonips_metadata_search_result_left'><{$smarty.const._MD_XOONIPS_OAIPMH_SEARCH_RESULT_LAST_UPDATE_DATE}></td>
     <td class='xoonips_metadata_search_result_right'><{$i.last_update_date}></td>
   </tr>
<{/if}>
<{if $i.creation_date != ''}>
   <tr>
     <td class='xoonips_metadata_search_result_left'><{$smarty.const._MD_XOONIPS_OAIPMH_SEARCH_RESULT_CREATION_DATE}></td>
     <td class='xoonips_metadata_search_result_right'><{$i.creation_date}></td>
   </tr>
<{/if}>
<{if $i.date != ''}>
   <tr>
     <td class='xoonips_metadata_search_result_left'><{$smarty.const._MD_XOONIPS_OAIPMH_SEARCH_RESULT_DATE}></td>
     <td class='xoonips_metadata_search_result_right'><{$i.date}></td>
   </tr>
<{/if}>
   <tr>
     <td class='xoonips_metadata_search_result_left'><{$smarty.const._MD_XOONIPS_OAIPMH_SEARCH_RESULT_LINK}></td>
     <td class='xoonips_metadata_search_result_right'>
<{if 1==preg_match( "/^(s?https?:\\/\\/[-_.!~*'\\(\\)a-zA-Z0-9;\\/?:\\@&=+\$,%#]+)/", $i.link)}>
       <a target="_blank" href='<{$i.link}>'><{$i.link|truncate:50:"...":true}></a>
<{else}>
       <{$i.link|truncate:50:"...":true}>
<{/if}>
     </td>
   </tr>

 </table>
<{/foreach}>

  <div style='text-align: center;'>
  <table width="100%" border="0">
   <tr>
    <td style="text-align: left;">
    </td>
    <td style="text-align: right;">
      <{if $maxpage > 1}>
        <{if $page > 1}>
        <a href="javascript:void(0);"
           onclick="$('xoonips_oampmh_search_result_page').value=<{$page-1}> $('xoonips_oampmh_search_result_form').submit(); return false;"><{$smarty.const._MD_XOONIPS_OAMPMH_SEARCH_RESULT_PAGENAVI_PREV}></a>&nbsp;
        <{else}>
          <{$smarty.const._MD_XOONIPS_OAMPMH_SEARCH_RESULT_PAGENAVI_PREV}>&nbsp;
        <{/if}>
        <{foreach item=i from=$pages}>
          <{if $i==$page}>
            <{$i}>
          <{else}>
        <a href="javascript:void(0);"
           onclick="$('xoonips_oampmh_search_result_page').value=<{$i}> $('xoonips_oampmh_search_result_form').submit(); return false;"><{$i}></a>
        <{/if}>
          &nbsp;
        <{/foreach}>
        <{if $page < $maxpage }>
        <a href="javascript:void(0);"
           onclick="$('xoonips_oampmh_search_result_page').value=<{$page+1}> $('xoonips_oampmh_search_result_form').submit(); return false;"><{$smarty.const._MD_XOONIPS_OAMPMH_SEARCH_RESULT_PAGENAVI_NEXT}></a>
        <{else}>
          <{$smarty.const._MD_XOONIPS_OAMPMH_SEARCH_RESULT_PAGENAVI_NEXT}>
        <{/if}>
      <{/if}>
    </td>
   </tr>
  </table>
  </div>

<{if $total_metadata_count > 0 }>
<form id='xoonips_oampmh_search_result_back_form2'
      action='oaipmh_search.php?action=default'
      method='post'>
  
  <input id='xoonips_oampmh_search_result_back_submit2' type='submit' value='<{$smarty.const._MD_XOONIPS_OAIPMH_SEARCH_RESULT_BACK}>' />
  <input type='hidden' name='repository_id' value='<{$repository_id}>' />
  <input type='hidden' name='keyword' value='<{$keyword}>' />
</form>
<{/if}>
