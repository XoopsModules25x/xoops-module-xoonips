<{* form to display link related to items(a part of detail page) *}>
<{* $Revision: 1.3 $ *}>
<{* 

display summary(in HTML) of linked (registered) item in edit

PARAMETERS
    $item_htmls: array of summary(HTML) of registered items

*}>
<!-- begin of xoonips_detail_related_to.tpl -->
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
<!-- end of xoonips_detail_related_to.tpl -->
