<{if $error_check_only}>
<{$smarty.const._MD_XOONIPS_IMPORT_ERROR_CKECK_DONE}><br>
<{/if}>
<{if $result}>
<{$smarty.const._MD_XOONIPS_IMPORT_NO_ERROR}><br>
<{else}>
<{$smarty.const._MD_XOONIPS_IMPORT_ERROR}><br>
<{/if}>
<{$smarty.const._MD_XOONIPS_IMPORT_REVIEW_LOG}><br>

<form id='form_submit_back' action='import.php?action=default' method='post'>
<textarea id="textarea_import_log" readonly="readonly" cols="80" rows="30" style="width:100%;">
[version]
1.00

[begin]
unknown

[finish]
unknown

[executer]
<{$uname}>

[number_of_items]
<{$number_of_items}>

[filename]
<{$filename}>

<{$log}>

[result]
<{if $result}>
result success
<{else}>
result failure
<{foreach item=e from=$errors}>
error <{$e.code}> <{$e.extra}>
<{/foreach}>
<{/if}>
</textarea>
<input class='formButton' id='submit_back' type='submit' value='<{$smarty.const._MD_XOONIPS_ITEM_BACK_BUTTON_LABEL}>'/>
</form>
