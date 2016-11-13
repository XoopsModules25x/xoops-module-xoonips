<{* $Revision: 1.18.2.1.2.4 $ *}>
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
    <td class="<{cycle name="oddeven"}>"><{$basic.description.value|nl2br}></td>
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
  
  <!-- Book Item Detail Information -->
  <tr>
   <td class="head"><{$smarty.const._MD_XNPBOOK_AUTHOR_LABEL}></td>
   <td class="<{cycle name="oddeven"}>">
<{include file='db:xoonips_confirm_multiple_field.tpl' vars=$xnpbook_author}>
   </td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPBOOK_EDITOR_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{$detail.editor.value}></td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPBOOK_PUBLISHER_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{$detail.publisher.value}></td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPBOOK_YEAR_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{$basic.publication_year.value}></td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPBOOK_URL_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{if $detail.url.value != ''}><a href="<{$detail.url.value}>" title="<{$detail.url.value}>" target="_blank"><{$detail.url.value|truncate:60}></a><{/if}></td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPBOOK_ISBN_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{$detail.isbn.value}></td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPBOOK_PDF_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{$attachment.value}></td>
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

<input type="hidden" name="editor"         value="<{$detail.editor.html_string}>"/>
<input type="hidden" name="publisher"      value="<{$detail.publisher.html_string}>"/>
<input type="hidden" name="isbn"           value="<{$detail.isbn.html_string}>"/>
<input type="hidden" name="url"            value="<{$detail.url.html_string}>"/>
