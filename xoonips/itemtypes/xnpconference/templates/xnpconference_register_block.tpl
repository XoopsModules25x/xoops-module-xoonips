<{* xnpconference register block *}>

<script type="text/javascript">
<!--
function onSubmitItemType(form){
  <{$xnpconference_author.table_name}>.trimFields();
  var result = true;
  if ( form.conference_title.value == '' ){
    window.alert( "<{$smarty.const._MD_XNPCONFERENCE_CONFERENCE_TITLE_REQUIRED}>" );
    result = false;
  }
  if ( form.place.value == '' ){
    window.alert( "<{$smarty.const._MD_XNPCONFERENCE_PLACE_REQUIRED}>" );
    result = false;
  }
  if ( <{$xnpconference_author.table_name}>.getNumOfFields() == 0 ) {
    result = false;
    window.alert( "<{$smarty.const._MD_XNPCONFERENCE_AUTHOR_REQUIRED}>" );
  }
  if ( form.conference_file.value == '' && form.conference_fileFileID.value == '' ){
    window.alert( "<{$smarty.const._MD_XNPCONFERENCE_PRESENTATION_FILE_REQUIRED}>" );
    result = false;
  }
  var dateFrom = new Date();
  var dateTo = new Date();
  dateFrom.setYear(form.conferenceFromYear.value);
  dateFrom.setMonth(form.conferenceFromMonth.value);
  dateFrom.setDate(form.conferenceFromDay.value);
  dateTo.setYear(form.conferenceToYear.value);
  dateTo.setMonth(form.conferenceToMonth.value);
  dateTo.setDate(form.conferenceToDay.value);
  if ( dateFrom.getTime() > dateTo.getTime() ){
    window.alert( "<{$smarty.const._MD_XNPCONFERENCE_DATE_ERROR}>" );
    result = false;
  }
  return result;
}
//-->
</script>

<table class="outer">
  <tr>
    <td class="head"><{$basic.doi.name}></td>
    <td class="<{cycle name="oddeven" values="odd,even"}>"><{$basic.doi.value}></td>
  </tr>
  <tr>
    <td width="30%" class="head"><{$basic.lang.name}></td>
    <td class="<{cycle name="oddeven"}>"><{$basic.lang.value}></td>
  </tr>
  <tr>
    <td class="head">
        <{$smarty.const._MD_XNPCONFERENCE_CONFERENCE_TITLE_LABEL}><{$smarty.const._MD_XOONIPS_ITEM_REQUIRED_MARK}></td>
    <td class="<{cycle name="oddeven"}>"><input size="50" type="text" name="conference_title" value="<{$detail.conference_title}>"/></td>
  </tr>
  <tr>
    <td class="head">
        <{$smarty.const._MD_XNPCONFERENCE_PLACE_LABEL}><{$smarty.const._MD_XOONIPS_ITEM_REQUIRED_MARK}></td>
    <td class="<{cycle name="oddeven"}>"><input size="50" type="text" name="place" value="<{$detail.place}>"/></td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPCONFERENCE_DATE_LABEL}><{$smarty.const._MD_XOONIPS_ITEM_REQUIRED_MARK}></td>
    <td class="<{cycle name="oddeven"}>"><{$detail.conference_date.value}></td>
  </tr>
  <tr>
    <td class="head">
        <{$smarty.const._MD_XNPCONFERENCE_PRESENTATION_TITLE_LABEL}><{$smarty.const._MD_XOONIPS_ITEM_REQUIRED_MARK}></td>
    <td class="<{cycle name="oddeven"}>"><{$basic.title.value}></td>
  </tr>
  <tr>
    <td class="head">
        <{$smarty.const._MD_XNPCONFERENCE_AUTHOR_LABEL}><{$smarty.const._MD_XOONIPS_ITEM_REQUIRED_MARK}></td>
    <td class="<{cycle name="oddeven"}>">
<{include file='db:xoonips_register_multiple_field.tpl' vars=$xnpconference_author}>
    </td>
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
  
  <tr>
    <td class="head"><{$smarty.const._MD_XNPCONFERENCE_ABSTRACT_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><textarea name="abstract" rows="4" cols="40"><{$detail.abstract}></textarea></td>
  </tr>
  <!-- file -->
  <tr>
    <td class="head"><{$smarty.const._MD_XNPCONFERENCE_PRESENTATION_FILE_LABEL}><{$smarty.const._MD_XOONIPS_ITEM_REQUIRED_MARK}></td>
    <td class="<{cycle name="oddeven"}>"><{$presentation_file.value}></td>
  </tr>
  <tr>
   <td class="head"><{$smarty.const._MD_XNPCONFERENCE_PRESENTATION_TYPE_LABEL}></td>
    <td class="<{cycle name="oddeven"}>">
      <select name="presentation_type">
        <{html_options options=$presentation_type selected=$presentation_type_selected}>
      </select>
    </td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPCONFERENCE_CONFERENCE_PAPER_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{$conference_paper.value}></td>
  </tr>
  <tr>
    <td class="head"><{$attachment_dl_limit.name}></td>
    <td class="<{cycle name="oddeven"}>"><{$attachment_dl_limit.value}></td>
  </tr>
  <tr>
    <td class="head"><{$attachment_dl_notify.name}></td>
    <td class="<{cycle name="oddeven"}>"><{$attachment_dl_notify.value}></td>
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

