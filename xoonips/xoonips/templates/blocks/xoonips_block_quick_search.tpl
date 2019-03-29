<{* quick search block *}>

<form style="margin-top: 0;" action="<{$block.submit_url}>" method="get">
  <input type="hidden" name="op" value="<{$block.op}>"/>
  <input type="text" name="keyword" size="16" value="<{$block.keyword}>"/>
  &nbsp;&nbsp;
  <select name="search_itemtype">
    <{html_options options=$block.search_itemtypes selected=$block.search_itemtypes_selected}>
  </select>
  <br>
  <input class="formButton" type="submit" value="<{$block.lang_search}>"/>

<{if !isset($block.advanced_search_enable) || $block.advanced_search_enable}>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <a href="<{$xoops_url}>/modules/xoonips/advanced_search.php"><{$block.lang_advanced_search}></a>
<{/if}>

</form>
