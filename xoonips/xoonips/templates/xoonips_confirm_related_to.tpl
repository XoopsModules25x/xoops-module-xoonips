<{* form to input link related to items(a part of confirm's page) *}>
<{* 

display HTML (summary of linked items)

PARAMETERS
    $item_htmls: HTML of item's summary( item_id => HTML )

*}>
<!-- begin of xoonips_confirm_related_to.tpl -->
<{if !empty( $item_htmls ) }>
<table width="100%" border="0" cellspacing="5">
  <tr style='vertical-align:middle; text-align:center;'>
   <th><{$smarty.const._MD_XOONIPS_ITEM_RELATED_TO_ITEM_SUMMARY}></th>
  </tr>
<{foreach item=i from=$item_htmls}>
  <tr valign="top">
    <td  class="<{cycle values="odd,even"}>">
     <{$i}>
    </td>
  </tr>
<{/foreach}>
</table>
<{/if}>
<!-- end of xoonips_confirm_related_to.tpl -->
