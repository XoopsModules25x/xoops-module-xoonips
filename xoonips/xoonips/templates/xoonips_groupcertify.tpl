<{*
template for display to group certify items


$indexes[] array of index information to be group certified
         array( group_index_id=>id of group index,
                indexex=array( array( 'id'=>index_id, 'path' => path string of index ), ... )...


copy original
$items[] array of item information to be certified
         array( item_id=>id of item,
                item_body=>HTML to display item's summary to certify,
                indexex=array( array( 'id'=>index_id, 'path' => path string of index ), ... )...

*}>
<{if !empty( $pankuzu )}>
<p><{$pankuzu}></p>
<{/if}>

<h3><{$smarty.const._MD_XOONIPS_ITEM_GROUP_CERTIFY_ITEM_TITLE}></h3>

<table >
 <tr class="head">
  <th><{$smarty.const._MD_XOONIPS_HEADER_GROUP_CERTIFY_ITEMS}></th>
 </tr>
<{if !empty( $group_indexes ) }>
 <{foreach item=i from=$group_indexes}>
 <tr>
  <td class="<{cycle values="odd,even"}>">
   <table>
    <tr>
     <td class="head" width="80"><{$smarty.const._MD_XOONIPS_ITEM_GROUP_INDEX_LABEL}></td>
     <td>
<table><tr><td width="90%">
<a href="listitem.php?index_id=<{$i.group_index_id}>"><{$i.group_index_path}></a>
<td width="10%"><{$smarty.const._MD_XOONIPS_ITEM_PENDING_NOW}></td></tr></table></td>
    </tr>
    <tr>
     <td class="head" width="80"><{$smarty.const._MD_XOONIPS_ITEM_INDEX_LABEL}></td>
     <td>
      <form name='xoonips_groupcertify<{$i.item_id}>' action="groupcertify.php" method="post">
      <{foreach item=j from=$i.indexes}>
        <input type='checkbox' name='index_ids[]' value='<{$j.id}>' />
      <a href="listitem.php?index_id=<{$j.id}>"><{$j.path}></a><br>
      <{/foreach}>
       <img src="images/arrow_ltr.png" alt="arrow" />
       With selected: 
       <input class="formButton" type="button" value="<{$smarty.const._MD_XOONIPS_ITEM_CERTIFY_BUTTON_LABEL}>" onclick="this.form.op.value='certify'; submit();" />
       <input class="formButton" type="button" value="<{$smarty.const._MD_XOONIPS_ITEM_UNCERTIFY_BUTTON_LABEL}>" onclick="this.form.op.value='uncertify'; submit();" />
       <input type='hidden' name='op' value='' />
       <input type='hidden' name='group_index_id' value='<{$i.group_index_id}>' />
       <{$token_ticket}>
      </form>
     </td>
    </tr>
   </table>
  </td>
 </tr>
 <{/foreach}>
<{else}>
 <tr>
  <td class="even" style="text-align: center;"><span style="font-weight: bold; color: red;"><{$smarty.const._MD_XOONIPS_ITEM_NO_GROUP_CERTIFY_ITEMS}></span></td>
 </tr>
<{/if}>
</table>
