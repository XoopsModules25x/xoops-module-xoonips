<{* xnppaper detail block *}>
<{* $Revision: 1.19.4.1.2.6 $ *}>
<form id="xoonips_edit_form" action="#">
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
    <td class="head"><{$smarty.const._MD_XNPPAPER_PUBMED_ID_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{$xoonips_item.detail.pubmed_link}></td>
  </tr>
  <!-- Basic Information -->
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

  <!-- Paper Item Detail Information -->
  <tr>
   <td class="head"><{$smarty.const._MD_XNPPAPER_AUTHOR_LABEL}></td>
   <td class="<{cycle name="oddeven"}>">
<{include file='db:xoonips_confirm_multiple_field.tpl' vars=$xoonips_item.xnppaper_author}>
   </td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPPAPER_JOURNAL_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{$xoonips_item.detail.journal}></td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPPAPER_YEAR_OF_PUBLICATION_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{$basic.publication_year.value}></td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPPAPER_VOLUME_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{$xoonips_item.detail.volume}></td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPPAPER_NUMBER_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{$xoonips_item.detail.number}></td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPPAPER_PAGE_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{$xoonips_item.detail.page}></td>
  </tr>
<{if !empty( $show_abstract ) }>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPPAPER_ABSTRACT_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{$xoonips_item.detail.abstract|nl2br}></td>
  </tr>
<{/if}>
<{if !empty( $show_pdf ) }>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPPAPER_PDF_REPRINT_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{$paper_pdf_reprint.value}></td>
  </tr>
<{/if}>
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
<input type='hidden' name='pubmed_id' value='<{$xoonips_item.detail.pubmed_id}>'/>
<input type='hidden' name='journal' value='<{$xoonips_item.detail.journal}>'/>
<input type='hidden' name='volume' value='<{$xoonips_item.detail.volume}>'/>
<input type='hidden' name='number' value='<{$xoonips_item.detail.number}>'/>
<input type='hidden' name='page' value='<{$xoonips_item.detail.page}>'/>
<input type='hidden' name='abstract' value='<{$xoonips_item.detail.abstract}>'/>
<input type='hidden' name='paper_pdf_reprintFileID' value='<{$xoonips_item.detail.paper_pdf_reprint.file_id}>'/>
<{$readme.hidden}>
<{$rights.hidden}>
<{$index.hidden}>
<{/if}>
</form>
