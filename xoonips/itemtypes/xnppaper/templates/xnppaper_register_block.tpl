<{* xnppaper register block *}>
<script type="text/javascript">
//<![CDATA[

// return true if all required parameters are filled
function onSubmitItemType( form ){
  <{$xnppaper_author.table_name}>.trimFields();
  var result = true;
  var focus_el = null;
  if ( <{$xnppaper_author.table_name}>.getNumOfFields() == 0 ) {
    alert( "<{$smarty.const._MD_XNPPAPER_AUTHOR_REQUIRED}>" );
    result = false;
  }
  if ( ! xoonips_formchecker.isFilledInputText( form.journal ) ) {
    alert( "<{$smarty.const._MD_XNPPAPER_JOURNAL_REQUIRED}>" );
    result = false;
    focus_el = form.journal;
  }
  if ( ! xoonips_formchecker.isDecimalInputText( form.publicationDateYear, true, 0, 9999 ) ) {
    alert( "<{$smarty.const._MD_XNPPAPER_YEAR_OF_PUBLICATION_REQUIRED}>" );
    result = false;
    if ( focus_el == null ) {
      focus_el = form.publicationDateYear;
    }
  }
  if ( ! xoonips_formchecker.isDecimalInputText( form.volume, false, 0 ) ) {
    alert( "<{$smarty.const._MD_XNPPAPER_VOLUME_BADSTRING}>" );
    result = false;
    if ( focus_el == null ) {
      focus_el = form.volume;
    }
  }
  if ( ! xoonips_formchecker.isDecimalInputText( form.number, false, 0 ) ) {
    alert( "<{$smarty.const._MD_XNPPAPER_NUMBER_BADSTRING}>" );
    result = false;
    if ( focus_el == null ) {
      focus_el = form.number;
    }
  }
  if ( focus_el != null ) {
    focus_el.focus();
  }
  return result;
}

// pubmed complete request
function xnppaper_pubmed_complete() {
  var el = document.getElementById( 'xnppaper_complete_button' );
  el.disabled = true;
<{if $is_register }>
  var form = document.getElementById( 'xoonips_registerform' );
<{else}>
  var form = document.getElementById( 'xoonips_editform' );
<{/if}>
  var pmid = form.pubmed_id.value;
  var url = '<{$smarty.const.XOONIPS_URL}>/backend.php?itemtype=xnppaper&action=pubmed_fillin'
;
  var params = 'pmid=' + pmid;
  var myAjax = new Ajax.Request( url, {
    method: 'get',
    parameters: params,
    requestHeaders: ['Referer', '<{$myurl}>'],
    onComplete: xnppaper_pubmed_oncomplete,
    onFilure: xnppaper_pubmed_onfailure
  } );
  return false;
}

function xnppaper_pubmed_oncomplete( request ) {
  if ( ! request.responseText.isJSON() ) {
    alert( 'informal result returend from backend query : ' + request.responseText );
  } else {
    xnppaper_pubmed_fillin( request );
  }
  var el = document.getElementById( 'xnppaper_complete_button' );
  el.disabled = false;
}

function xnppaper_pubmed_onfailure( request ) {
  alert( 'failed to request backend query' );
  var el = document.getElementById( 'xnppaper_complete_button' );
  el.disabled = false;
}

function xnppaper_pubmed_fillin( request ) {
  var json = eval( '(' + request.responseText + ')' );
  if ( typeof ( json.error ) == 'string' ) {
    alert( json.error );
  } else {
    <{if $is_register }>
    var form = document.getElementById( 'xoonips_registerform' );
    <{else}>
    var form = document.getElementById( 'xoonips_editform' );
    <{/if}>
    form.title.value = json.title;
    var keywords = '';
    for ( var i = 0; i < json.keywords.length; i++ ) {
      if ( i != 0 ) keywords += ',';
      keywords += json.keywords[i];
    }
    if( json.keywords.length > 0 ) {
      form.keywords.value = keywords;
    }
    //form.author.value = authors;
    <{$xnppaper_author.table_name}>.deleteAllFields();
    for ( var i = 0; i < json.author.length; i++ ) {
      <{$xnppaper_author.table_name}>.setField( i, json.author[i] );
    }
    form.journal.value = json.journal;
    form.publicationDateYear.value = json.year;
    form.volume.value = json.volume;
    form.number.value = json.issue;
    form.page.value = json.page;
    // javascript of safari couldn't handle keyword 'abstract'
    var abst = document.getElementById( 'xnppaper_abstract' );
    abst.value = json.abst;
  }
  return true;
}

//]]>
</script>

<table class="outer">
  <!-- Basic Information -->
  <tr>
    <td class="head"><{$basic.doi.name}></td>
    <td class="<{cycle name="oddeven" values="odd,even"}>"><{$basic.doi.value}></td>
  </tr>
  <tr>
    <td class="head"><{$basic.lang.name}></td>
    <td class="<{cycle name="oddeven"}>"><{$basic.lang.value}></td>
  </tr>
  <tr>
    <td width="30%" class="head"><{$smarty.const._MD_XNPPAPER_PUBMED_ID_LABEL}></td>
    <td class="<{cycle name="oddeven"}>">
        <input type="text" name="pubmed_id" value="<{$detail.pubmed_id}>"/>
        <button id="xnppaper_complete_button" class="formButton" type="button" onclick="xnppaper_pubmed_complete();">Complete</button>
    </td>
  </tr>
  <tr>
    <td class="head"><{$basic.title.name}></td>
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

  <!-- Paper Item Detail Information -->
  <tr>
    <td class="head">
        <{$smarty.const._MD_XNPPAPER_AUTHOR_LABEL}><{$smarty.const._MD_XOONIPS_ITEM_REQUIRED_MARK}></td>
    <td class="<{cycle name="oddeven"}>">
<{include file='db:xoonips_register_multiple_field.tpl' vars=$xnppaper_author}>
    </td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPPAPER_JOURNAL_LABEL}><{$smarty.const._MD_XOONIPS_ITEM_REQUIRED_MARK}></td>
    <td class="<{cycle name="oddeven"}>"><input size="50" type="text" name="journal" value="<{$detail.journal}>" /></td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPPAPER_YEAR_OF_PUBLICATION_LABEL}><{$smarty.const._MD_XOONIPS_ITEM_REQUIRED_MARK}></td>
    <td class="<{cycle name="oddeven"}>">
      <{$basic.publication_year.value}>
      <input type="hidden" name="publicationDateMonth" value="0"/>
      <input type="hidden" name="publicationDateDay" value="0"/>
    </td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPPAPER_VOLUME_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><input type="text" name="volume" value="<{$detail.volume}>" /></td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPPAPER_NUMBER_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><input type="text" name="number" value="<{$detail.number}>" /></td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPPAPER_PAGE_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><input type="text" name="page" value="<{$detail.page}>" /></td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPPAPER_ABSTRACT_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><textarea id="xnppaper_abstract" name="abstract" rows="4" cols="40"><{$detail.abstract}></textarea></td>
  </tr>
  <tr>
    <td class="head"><{$smarty.const._MD_XNPPAPER_PDF_REPRINT_LABEL}></td>
    <td class="<{cycle name="oddeven"}>"><{$paper_pdf_reprint.value}></td>
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

