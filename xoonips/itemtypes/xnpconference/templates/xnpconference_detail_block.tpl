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
    <td class="head"><{$smarty.const._MD_XNPCONFERENCE_CONFERENCE_TITLE_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{$xoonips_item.detail.conference_title}></td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPCONFERENCE_PLACE_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{$xoonips_item.detail.place}></td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPCONFERENCE_DATE_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{$xoonips_item.detail.conference_date}></td>
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
  <tr>
    <td class="head"><{$smarty.const._MD_XNPCONFERENCE_PRESENTATION_TITLE_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{$basic.title.value|nl2br}></td>
  </tr>
  <tr>
   <td class="head"><{$smarty.const._MD_XNPCONFERENCE_AUTHOR_LABEL}></td>
   <td class="<{cycle name="oddeven"}>">
<{include file='db:xoonips_confirm_multiple_field.tpl' vars=$xoonips_item.xnpconference_author}>
   </td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPCONFERENCE_ABSTRACT_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{$xoonips_item.detail.abstract|nl2br}></td>
  </tr>  

  <!-- file -->
  <tr>
    <td class="head"><{$smarty.const._MD_XNPCONFERENCE_PRESENTATION_FILE_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{$presentation_file.value}></td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPCONFERENCE_PRESENTATION_TYPE_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{$xoonips_item.detail.presentation_type}></td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPCONFERENCE_CONFERENCE_PAPER_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{$conference_paper.value}></td>
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
<input type="hidden" name="conference_title" value="<{$xoonips_item.detail.conference_title}>"/>
<input type="hidden" name="place" value="<{$xoonips_item.detail.place}>"/>
<input type="hidden" name="conferenceFromYear" value="<{$xoonips_item.detail.conference_from_year}>"/>
<input type="hidden" name="conferenceFromMonth" value="<{$xoonips_item.detail.conference_from_month}>"/>
<input type="hidden" name="conferenceFromDay" value="<{$xoonips_item.detail.conference_from_mday}>"/>
<input type="hidden" name="conferenceToYear" value="<{$xoonips_item.detail.conference_to_year}>"/>
<input type="hidden" name="conferenceToMonth" value="<{$xoonips_item.detail.conference_to_month}>"/>
<input type="hidden" name="conferenceToDay" value="<{$xoonips_item.detail.conference_to_mday}>"/>
<input type="hidden" name="abstract" value="<{$xoonips_item.detail.abstract}>"/>
<input type="hidden" name="presentation_type" value="<{$xoonips_item.detail.presentation_type_value}>"/>
<input type="hidden" name="conference_fileFileID" value="<{$xoonips_item.detail.conference_file.file_id}>"/>
<input type="hidden" name="conference_paperFileID" value="<{$xoonips_item.detail.conference_paper.file_id}>"/>
<input type="hidden" name="attachment_dl_limit" value="<{$xoonips_item.detail.attachment_dl_limit}>"/>
<input type="hidden" name="attachment_dl_notify" value="<{$xoonips_item.detail.attachment_dl_notify}>"/>
<{$index.hidden}>
<{/if}>
</form>
