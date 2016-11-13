<{*
  $detail
  $params
*}>

<h3><{$smarty.const._MD_XOONIPS_METADATA_SEARCH_LABEL}></h3>

<form action='itemselect.php' method='post' id='xoonips_metadata_search_form'>
    <{foreach item=i from=$params}>
      <input type='hidden' name='<{$i.name}>'  value='<{$i.value}>' />
    <{/foreach}>
    <table width="100%" border="0" cellspacing="5">
    <{foreach item=i from=$detail}>
      <tr valign="top">
        <td class="<{cycle name="cycle3" values="odd,even"}>"><{$i.tag}></td>
        <td class="<{cycle name="cycle4" values="odd,even"}>" ><{$i.value}></td>
      </tr>
    <{/foreach}>
    </table>
    
    <{* Back button *}>
    <input class="formButton" type='submit' value='<{$smarty.const._MD_XOONIPS_ITEM_BACK_BUTTON_LABEL}>' />
</form>

<br>
