<{* login block *}>
<form id='xoonips_login_form' style="margin-top: 0;" action="<{$xoops_url}>/modules/xoonips/user.php" method="post">
    <{$block.lang_username}><br>
    <input type="text" name="uname" size="12" value="<{$block.unamevalue}>" maxlength="25" /><br>
    <{$block.lang_password}><br>
    <input type="password" name="pass" size="12" maxlength="32" /><br>
    <!-- <input type="checkbox" name="rememberme" value="On" class ="formButton" /><{$block.lang_rememberme}><br> //-->
    <input type="hidden" name="xoops_redirect" value="<{$xoops_requesturi}>" />
    <input type="hidden" name="op" value="login" />
    <input id='xoonips_login_submit' class="formButton" type="submit" value="<{$block.lang_login}>" /><br>
</form>
<{if $block.use_ssl == '1'}>
<a href="javascript:openWithSelfMain('<{$block.sslloginlink}>', 'ssllogin', 300, 200);"><{$smarty.const._MB_XOONIPS_LOGIN_SECURE}></a>
<{/if}>
<a href="<{$xoops_url}>/modules/xoonips/user.php?op=lostpass"><{$block.lang_lostpass}></a>
<br><br>
<a href="<{$xoops_url}>/modules/xoonips/registeruser.php"><{$block.lang_registernow}></a>
