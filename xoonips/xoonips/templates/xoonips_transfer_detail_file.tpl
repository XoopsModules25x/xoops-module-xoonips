<{$fileinfo.file_name}><br>
<table>
 <tr>
  <td><{$smarty.const._MD_XOONIPS_ITEM_TYPE_LABEL}></td>
  <td>: <{$fileinfo.mime_type}></td>
 </tr>
 <tr>
  <td><{$smarty.const._MD_XOONIPS_ITEM_SIZE_LABEL}></td>
  <td>: <{$fileinfo.file_size}></td>
 </tr>
 <tr>
  <td><{$smarty.const._MD_XOONIPS_ITEM_LAST_UPDATED_LABEL}></td>
  <td>: <{$fileinfo.last_update_date|date_format:"%b %e, %Y"}></td>
 </tr>
 <tr>
  <td><{$smarty.const._MD_XOONIPS_ITEM_DOWNLOAD_COUNT_LABEL}></td>
  <td>: <{$fileinfo.download_count}></td>
 </tr>
</table>
<br>
<{$smarty.const._MD_XOONIPS_ITEM_TOTAL_DOWNLOAD_COUNT_SINCE_LABEL}><{$fileinfo.item_creation_date|date_format:"%b %e, %Y"}> : <{$fileinfo.total_download_count}><br>
