<{if $result}>
<{$smarty.const._MD_XOONIPS_IMPORT_IMPORT_SUCCESSFULLY}><br>
<{else}>
<{$smarty.const._MD_XOONIPS_IMPORT_ERROR}><br>
<{/if}>
<{$smarty.const._MD_XOONIPS_IMPORT_REVIEW_LOG}><br>

<form id='form_submit_back' action='import.php?action=default' method='post'>
<textarea style="width:100%;" id="textarea_import_log" readonly="readonly" cols="80" rows="30">
[version]
1.00

[begin]
<{$begin_time|date_format:"%Y-%m-%d %H:%M:%S"}>

[finish]
<{$finish_time|date_format:"%Y-%m-%d %H:%M:%S"}>

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
<{foreach item=url from=$item_urls}>
item <{$url.pseudo_id}> <{$url.url}>
<{/foreach}>
<{else}>
result failure
<{foreach item=e from=$errors}>
error <{$e.code}> <{$e.extra}>
<{/foreach}>
<{/if}>


</textarea>
<input class='formButton' id='submit_back' type='submit' value='<{$smarty.const._MD_XOONIPS_ITEM_BACK_BUTTON_LABEL}>'/>
</form>
