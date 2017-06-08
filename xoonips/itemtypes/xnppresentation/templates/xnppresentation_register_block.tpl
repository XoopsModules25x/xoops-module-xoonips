<{* xnppresentation register block *}>
<script type="text/javascript">
<!--
function onSubmitItemType(form){
  <{$xnppresentation_creator.table_name}>.trimFields();
  var result = true;
  if ( <{$xnppresentation_creator.table_name}>.getNumOfFields() == 0 ) {
    window.alert( "<{$smarty.const._MD_XNPPRESENTATION_CREATOR_REQUIRED}>" );
    result = false;
  }
  if ( form.publicationDateYear.value == '' ){
    window.alert( "<{$smarty.const._MD_XNPPRESENTATION_YEAR_REQUIRED}>" );
    result = false;
  }
  if ( form.presentation_file.value == '' && form.presentation_fileFileID.value == '' ){
    window.alert( "<{$smarty.const._MD_XNPPRESENTATION_PRESENTATION_FILE_REQUIRED}>" );
    result = false;
  }
  return result;
}
//-->
</script>

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
    <td class="<{cycle name="oddeven"}>"><{$basic.title.value}></td>
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
    <td class="head"><{$smarty.const._MD_XNPPRESENTATION_DATE_LABEL}><{$smarty.const._MD_XOONIPS_ITEM_REQUIRED_MARK}></td>
    <td class="<{cycle name="oddeven"}>"><{$basic.publication_date.value}></td>
  </tr>
<{if !empty( $basic.last_update_date.value ) }>
  <tr>
    <td class="head"><{$basic.last_update_date.name}></td>
    <td class="<{cycle name="oddeven"}>"><{$basic.last_update_date.value}></td>
  </tr>
<{/if}>
<{if !empty( $basic.creation_date.value ) }>
  <tr>
    <td class="head"><{$basic.creation_date.name}></td>
    <td class="<{cycle name="oddeven"}>"><{$basic.creation_date.value}></td>
  </tr>
<{/if}>
<{if !empty( $basic.contributor.value ) }>
  <tr>
    <td class="head"><{$basic.contributor.name}></td>
    <td class="<{cycle name="oddeven"}>"><{$basic.contributor.value}></td>
  </tr>
<{/if}>
<{if !empty( $basic.item_type.value ) }>
  <tr>
    <td class="head"><{$basic.item_type.name}></td>
    <td class="<{cycle name="oddeven"}>"><{$basic.item_type.value}></td>
  </tr>
<{/if}>
<{if !empty( $basic.change_log.value ) }>
  <tr>
    <td class="head"><{$basic.change_log.name}></td>
    <td class="<{cycle name="oddeven"}>"><{$basic.change_log.value}></td>
  </tr>
<{/if}>
<{if !empty( $basic.change_logs.value ) }>
  <tr>
    <td class="head"><{$basic.change_logs.name}></td>
    <td class="<{cycle name="oddeven"}>"><{$basic.change_logs.value}></td>
  </tr>
<{/if}>
  
  <!-- Presentation Item Detail Information -->
  <tr>
    <td class="head"><{$smarty.const._MD_XNPPRESENTATION_PRESENTATION_TYPE_LABEL}></td>
    <td class="<{cycle name="oddeven"}>">
      <select name="presentation_type">
        <{html_options options=$presentation_type selected=$presentation_type_selected}>
      </select>
    </td>
  </tr>
  <tr>
    <td class="head">
        <{$smarty.const._MD_XNPPRESENTATION_CREATOR_LABEL}><{$smarty.const._MD_XOONIPS_ITEM_REQUIRED_MARK}></td>
    <td class="<{cycle name="oddeven"}>">
<{include file='db:xoonips_register_multiple_field.tpl' vars=$xnppresentation_creator}>
    </td>
  </tr>
  <!-- file -->
  <tr>
    <td class="head"><{$preview.name}></td>
    <td class="<{cycle name="oddeven"}>"><{$preview.value}></td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPPRESENTATION_PRESENTATION_FILE_LABEL}><{$smarty.const._MD_XOONIPS_ITEM_REQUIRED_MARK}></td>
    <td class="<{cycle name="oddeven"}>"><{$presentation_file.value}></td>
  </tr>
  <tr>
    <td class="head"><{$attachment_dl_limit.name}></td>
    <td class="<{cycle name="oddeven"}>"><{$attachment_dl_limit.value}></td>
  </tr>
  <tr>
    <td class="head"><{$attachment_dl_notify.name}></td>
    <td class="<{cycle name="oddeven"}>"><{$attachment_dl_notify.value}></td>
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

