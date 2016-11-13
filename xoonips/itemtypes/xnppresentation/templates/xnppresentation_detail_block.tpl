<{* $Revision: 1.17.8.5 $ *}>
<form id="xoonips_edit_form" action="#">
<table class="outer">
  <!-- Basic Information -->
  <tr>
    <td class="head"><{$basic.doi.name}></td>
    <td class="<{cycle name="oddeven" values="odd,even"}>"><{$basic.doi.value}></td>
  </tr>
  <tr>
    <td width="30%" class="head"><{$basic.lang.name}></td>
    <td class="<{cycle name="oddeven"}>"><{$basic.lang.value}></td>
  </tr>
  <tr>
    <td width="30%" class="head"><{$basic.title.name}></td>
    <td class="<{cycle name="oddeven"}>"><{$basic.title.value|nl2br}></td>
  </tr>
  <tr>
    <td class="head"><{$basic.keywords.name}></td>
    <td class="<{cycle name="oddeven"}>"><{$basic.keywords.value}></td>
  </tr>
  <tr>
    <td class="head"><{$basic.description.name}></td>
    <td class="<{cycle name="oddeven"}>"><{$basic.description.value}></td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPPRESENTATION_DATE_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{$basic.publication_date.value}></td>
  </tr>
  <tr>
    <td class="head"><{$basic.last_update_date.name}></td>
    <td class="<{cycle name="oddeven"}>"><{$basic.last_update_date.value}></td>
  </tr>
  <tr>
    <td class="head"><{$basic.creation_date.name}></td>
    <td class="<{cycle name="oddeven"}>"><{$basic.creation_date.value}></td>
  </tr>
  <tr>
    <td class="head"><{$basic.contributor.name}></td>
    <td class="<{cycle name="oddeven"}>"><a href="<{$xoops_url}>/modules/xoonips/showusers.php?uid=<{$basic.uid.value}>" target="_self"><{$basic.contributor.value}></a></td>
  </tr>
  <tr>
    <td class="head"><{$basic.item_type.name}></td>
    <td class="<{cycle name="oddeven"}>"><{$basic.item_type.value}></td>
  </tr>
  <tr>
    <td class="head"><{$basic.change_logs.name}></td>
    <td class="<{cycle name="oddeven"}>"><{$basic.change_logs.value}></td>
  </tr>
  
  <!-- Presentation Item Detail Information -->
  <tr>
    <td class="head"><{$smarty.const._MD_XNPPRESENTATION_PRESENTATION_TYPE_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{$xoonips_item.detail.presentation_type}></td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPPRESENTATION_CREATOR_LABEL}></td>
    <td class="<{cycle name="oddeven"}>">
<{include file='db:xoonips_confirm_multiple_field.tpl' vars=$xoonips_item.xnppresentation_creator}>
    </td>
  </tr>
  
  <!-- file -->
  <tr>
    <td class="head"><{$preview.name}></td>
    <td class="<{cycle name="oddeven"}>"><{$preview.value}></td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPPRESENTATION_PRESENTATION_FILE_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{$presentation_file.value}></td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XOONIPS_ITEM_README_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{$readme.value}></td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XOONIPS_ITEM_RIGHTS_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{$rights.value}></td>
  </tr>

  <!-- index -->
  <tr>
    <td class="head"><{$index.name}></td>
    <td class="<{cycle name="oddeven"}>"><{$index.value}></td>
  </tr>
  <!-- related_to -->
  <tr>
    <td class="head"><{$basic.related_to.name}></td>
    <td class="<{cycle name="oddeven"}>"><{$basic.related_to.value}></td>
  </tr>
</table>
<{if $editable }>
<{$basic.hidden}>
<input type="hidden" name="presentation_type" value="<{$xoonips_item.detail.presentation_type_value}>"/>
<input type="hidden" name="attachment_dl_limit" value="<{$xoonips_item.detail.attachment_dl_limit.value}>"/>
<input type="hidden" name="attachment_dl_notify" value="<{$xoonips_item.detail.attachment_dl_notify.value}>"/>
<input type="hidden" name="presentation_fileFileID" value="<{$xoonips_item.detail.presentation_file.file_id}>"/>
<{$preview.hidden}>
<{$readme.hidden}>
<{$rights.hidden}>
<{$index.hidden}>
<{/if}>
</form>

