<tr>
  <td width="30%" class="head"><{$smarty.const._MD_XOONIPS_ITEM_TITLE_LABEL}></td>
  <td class="<{cycle name="oddeven"}>">
<{section name=i loop=$xoonips_item.titles}>
    <{$xoonips_item.titles[i].title}><br>
<{/section}>
  </td>
</tr>
