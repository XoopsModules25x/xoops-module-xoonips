<{* form to display download confirmation (a part of detail page) *}>
<{* 

// some codes are from lightbox v2.02

known bug: 
  if the body tag has margin or padding, the shadow overlay doesn't stretch to cover full browser window.

PARAMETERS
    $files[]['fileID']: file ID
    $files[]['fileName']: file name
    $files[]['mimeType']: mime type
    $files[]['fileSizeStr']: file size
    $files[]['lastUpdated']: file last updated
    $files[]['token']: xoops_token for download
    $use_license: need license agreement
    $use_cc: use creative commons license
    $rights: license text or license html
    $download_file_id: auto-download this file
    $attachment_dl_notify: need download notification agreement
    $download_url: 'download.php/urlencoded_utf8_filename'(safari) or 'download.php'(other)

*}>
<{if $download_file_id}>
<script type="text/javascript">
<!--
var old = window.onload;
window.onload = function(){ 
	if ( typeof(old) == "function" )
		old();
	var e = document.getElementById( "xoonips_download_button_<{$download_file_id}>" );
	if ( e ) {
        xoonips_download_confirmation( < {$download_file_id} >
    )
    }
}
//-->
</script>
<{/if}>
<{if $use_license || $attachment_dl_notify}>
<script type="text/javascript">
<!--
function xoonips_download_confirmation(file_id){
	xoonips_hideSelectBoxes();
	
	// move confirmation html to end of <body>
	var overlay = document.getElementById('xoonips_overlay');
	var lightbox = document.getElementById('xoonips_lightbox');
	var body = document.getElementsByTagName('body').item(0);
	body.insertBefore( overlay, null );
	body.insertBefore( lightbox, null );
	
	// overlay
	var arrayPageSize = xoonips_getPageSize();
	overlay.style.height = arrayPageSize[1] + "px";
	overlay.style.display = 'block';
	
	// calculate top offset for the lightbox and display 
	var arrayPageSize = xoonips_getPageSize();
	var arrayPageScroll = xoonips_getPageScroll();
	var lightboxTop = arrayPageScroll[1] + (arrayPageSize[3] / 15);
	lightbox.style.top = lightboxTop + "px";
	lightbox.style.display = 'block';
	
	// initialize controls
	var form = document.getElementById('xoonips_download_form_' + file_id);
	var button = form.download;
	var radio_notify  = form.radio_notify;
	var radio_license = form.radio_license;
	if ( radio_notify  ) radio_notify [1].checked = 'checked';
	if ( radio_license ) radio_license[1].checked = 'checked';
	button.disabled = true;
	
	var file_ids = [
<{foreach name='files' item=file from=$files}>
	<{$file.fileID}><{if !$smarty.foreach.files.last}>,<{/if}>
<{/foreach}>
]
    for ( i = 0; i < file_ids.length; i++ ){
		var page = document.getElementById('xoonips_download_page_' + file_ids[i]);
		if ( page )
			page.style.display = ( file_ids[i] == file_id ) ? 'block' : 'none';
	}
}

function xoonips_change_download_enabled(obj){
	var form = obj.form;
	var button = form.download;
	var radio_notify  = form.radio_notify ;
	var radio_license = form.radio_license;
	if      ( radio_notify  && radio_notify [1].checked ) button.disabled = true;
	else if ( radio_license && radio_license[1].checked ) button.disabled = true;
	else button.disabled = false;
	return true;
}

function xoonips_close_download_confirmation(){
	xoonips_showSelectBoxes();
	var overlay = document.getElementById('xoonips_overlay');
	overlay.style.display = 'none';
	
	var lightbox = document.getElementById('xoonips_lightbox');
	lightbox.style.display = 'none';
	return true;
}

//
// getPageScroll()
// Returns array with x,y page scroll values.
// Core code from - quirksmode.org
//
function xoonips_getPageScroll(){

	var yScroll;

	if (self.pageYOffset) {
		yScroll = self.pageYOffset;
	} else if (document.documentElement && document.documentElement.scrollTop){	 // Explorer 6 Strict
		yScroll = document.documentElement.scrollTop;
	} else if (document.body) {// all other Explorers
		yScroll = document.body.scrollTop;
	}

	arrayPageScroll = new Array('',yScroll) 
	return arrayPageScroll;
}

//
// getPageSize()
// Returns array with page width, height and window width, height
// Core code from - quirksmode.org
// Edit for Firefox by pHaez
//
function xoonips_getPageSize(){
	
	var xScroll, yScroll;
	
	if (window.innerHeight && window.scrollMaxY) {	
		xScroll = document.body.scrollWidth;
		yScroll = window.innerHeight + window.scrollMaxY;
	} else if (document.body.scrollHeight > document.body.offsetHeight){ // all but Explorer Mac
		xScroll = document.body.scrollWidth;
		yScroll = document.body.scrollHeight;
	} else { // Explorer Mac...would also work in Explorer 6 Strict, Mozilla and Safari
		xScroll = document.body.offsetWidth;
		yScroll = document.body.offsetHeight;
	}
	
	var windowWidth, windowHeight;
	if (self.innerHeight) {	// all except Explorer
		windowWidth = self.innerWidth;
		windowHeight = self.innerHeight;
	} else if (document.documentElement && document.documentElement.clientHeight) { // Explorer 6 Strict Mode
		windowWidth = document.documentElement.clientWidth;
		windowHeight = document.documentElement.clientHeight;
	} else if (document.body) { // other Explorers
		windowWidth = document.body.clientWidth;
		windowHeight = document.body.clientHeight;
	}	
	
	// for small pages with total height less then height of the viewport
	if(yScroll < windowHeight){
		pageHeight = windowHeight;
	} else { 
		pageHeight = yScroll;
	}

	// for small pages with total width less then width of the viewport
	if(xScroll < windowWidth){	
		pageWidth = windowWidth;
	} else {
		pageWidth = xScroll;
	}

	
	arrayPageSize = new Array(pageWidth,pageHeight,windowWidth,windowHeight) 
	return arrayPageSize;
}

function xoonips_showSelectBoxes(){
	selects = document.getElementsByTagName("select");
	for (i = 0; i != selects.length; i++) {
		selects[i].style.visibility = "visible";
	}
}

function xoonips_hideSelectBoxes(){
	selects = document.getElementsByTagName("select");
	for (i = 0; i != selects.length; i++) {
		selects[i].style.visibility = "hidden";
	}
}
//-->
</script>
<div style="opacity: 0.8; display: none;" id="xoonips_overlay">
</div>
<div style="display: none;" id="xoonips_lightbox">
 <div style="width: 570px;" id="xoonips_outerImageContainer" >
  <div id="xoonips_imageContainer">
   <{foreach name='files' item=file from=$files}>
      <div id="xoonips_download_page_<{$file.fileID}>" style="display: none;" >
       <form action='<{$download_url}>' method='post' onsubmit='xoonips_close_download_confirmation()' id='xoonips_download_form_<{$file.fileID}>'>
        <input type='hidden' name='file_id' value='<{$file.fileID}>' />
        <input type='hidden' name='xoonips_download_with_token' value='1' />
        <{$file.token}>
        <div style='text-align: left;'>
          <{$smarty.const._MD_XOONIPS_ITEM_ATTACHMENT_FILE_INFO_TITLE_LABEL}>
          <div class='xoonips_download_box'>
            <{$file.fileName}><br>
            <table style='width: auto;'>
             <tr>
              <td><{$smarty.const._MD_XOONIPS_ITEM_TYPE_LABEL}></td>
              <td>: <{$file.mimeType}></td>
             </tr>
             <tr>
              <td><{$smarty.const._MD_XOONIPS_ITEM_SIZE_LABEL}></td>
              <td>: <{$file.fileSizeStr}></td>
             </tr>
             <tr>
              <td><{$smarty.const._MD_XOONIPS_ITEM_LAST_UPDATED_LABEL}></td>
              <td>: <{$file.lastUpdated}></td>
             </tr>
            </table>
          </div>
        <br>
        <{if $use_license}>
            <{$smarty.const._MD_XOONIPS_ITEM_ATTACHMENT_LICENSE_TITLE_LABEL}>
            <div class='xoonips_download_box'>
              <{$smarty.const._MD_XOONIPS_ITEM_ATTACHMENT_LICENSE_QUERY_LABEL}>
              <{if $use_cc}>
                <div class="creativecommons"><{$rights}></div>
              <{else}>
                <textarea readonly='readonly' rows='10' cols='60' style="width:480px;"><{$rights}></textarea><br>
              <{/if}>
              <input type='radio' name='radio_license' value='1' onclick='xoonips_change_download_enabled(this);' /><{$smarty.const._MD_XOONIPS_ITEM_ATTACHMENT_LICENSE_YES_LABEL}><br>
              <input type='radio' name='radio_license' value='0' onclick='xoonips_change_download_enabled(this);' checked='checked' /><{$smarty.const._MD_XOONIPS_ITEM_ATTACHMENT_LICENSE_NO_LABEL}><br>
            </div>
          <br>
        <{/if}>
        <{if $attachment_dl_notify}>
            <{$smarty.const._MD_XOONIPS_ITEM_ATTACHMENT_DL_NOTIFY_TITLE_LABEL}>
            <div class='xoonips_download_box'>
              <{$smarty.const._MD_XOONIPS_ITEM_ATTACHMENT_DL_NOTIFY_QUERY_LABEL}><br>
              <input type='radio' name='radio_notify' value='1' onclick='xoonips_change_download_enabled(this);' /><{$smarty.const._MD_XOONIPS_ITEM_ATTACHMENT_DL_NOTIFY_YES_LABEL}><br>
              <input type='radio' name='radio_notify' value='0' onclick='xoonips_change_download_enabled(this);' checked='checked' /><{$smarty.const._MD_XOONIPS_ITEM_ATTACHMENT_DL_NOTIFY_NO_LABEL}><br>
            </div>
          <br>
        <{/if}>
        </div>
        <{if $use_license && $attachment_dl_notify}>
          <{$smarty.const._MD_XOONIPS_ITEM_ATTACHMENT_NEED_AGREE_BOTH_LABEL}>
        <{else}>
          <{$smarty.const._MD_XOONIPS_ITEM_ATTACHMENT_NEED_AGREE_LABEL}>
        <{/if}>
        <br>
        <input class="formButton" type='submit' name='download' value='<{$smarty.const._MD_XOONIPS_ITEM_ATTACHMENT_DOWNLOAD_LABEL}>' disabled='disabled' />
        <input class="formButton" type='button' value='<{$smarty.const._MD_XOONIPS_ITEM_ATTACHMENT_CANCEL_LABEL}>' onclick='xoonips_close_download_confirmation()' />
       </form>
      </div>
   <{/foreach}>
  </div>
 </div>
</div>
<{/if}>
