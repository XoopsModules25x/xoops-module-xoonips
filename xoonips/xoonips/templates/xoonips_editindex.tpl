<{* page for edit index *}>
<{* $Revision: 1.16.2.1.2.8 $ *}>

<p>
<{if $open_level == $smarty.const.OL_GROUP_ONLY || $xid == $smarty.const.IID_ROOT }><{* group_only or ROOT index *}>
<{$smarty.const._MI_XOONIPS_ACCOUNT_PANKUZU_GROUP_ADMINISTRATOR}>
<{$smarty.const._MI_XOONIPS_ACCOUNT_PANKUZU_SEPARATOR}>
<{$smarty.const._MD_XOONIPS_INDEX_PANKUZU_EDIT_GROUP_INDEX_KEYWORD}>
<{elseif $open_level == $smarty.const.OL_PUBLIC }>
<{$smarty.const._MI_XOONIPS_ACCOUNT_PANKUZU_MODERATOR}>
<{$smarty.const._MI_XOONIPS_ACCOUNT_PANKUZU_SEPARATOR}>
<{$smarty.const._MD_XOONIPS_INDEX_PANKUZU_EDIT_PUBLIC_INDEX_KEYWORD}>
<{elseif $open_level == $smarty.const.OL_PRIVATE }>
<{$smarty.const._MI_XOONIPS_ACCOUNT_PANKUZU_PLATFORM_USER}>
<{$smarty.const._MI_XOONIPS_ACCOUNT_PANKUZU_SEPARATOR}>
<{$smarty.const._MD_XOONIPS_INDEX_PANKUZU_EDIT_PRIVATE_INDEX_KEYWORD}>
<{/if}>
</p>

<h3><{$smarty.const._MD_XOONIPS_INDEX_TITLE_EDIT}></h3>

<{* display error message *}>
<{if $error_message}>
<{foreach item=error_message from=$error_message}>
  <span style="color: red;"><{$error_message}></span><br>
<{/foreach}>
<br>
<{/if}>

<{* display current place *}>
  <{foreach item=index from=$index_path}>
  / <a href="editindex.php?index_id=<{$index.item_id}>"><{$index.html_title}></a>
  <{/foreach}><hr />

<{if $create_permission }>
<h4><{$smarty.const._MD_XOONIPS_INDEX_TITLE_ADD}></h4>
<form action="editindex.php" method="post"<{$accept_charset}>>
<{if $limitLabel }>
<{$limitLabel}>: <{$indexCount}> (max=<{$indexNumberLimit}>)<br>
<{/if}>
<input type="hidden" name="op" value="register"/>
<input type="hidden" name="index_id" value="<{$xid}>"/>
<{$token_ticket}>
<table width="100%" border="0" cellspacing="5">
  <tr valign="top" class="head">
    <th colspan="2"><{$smarty.const._MD_XOONIPS_INDEX_TITLE_NEW_INDEX_KEYWORD}></th>
  </tr>
  <tr valign="top">
    <td class="odd"><input type="text" name="new_index_name" size="30"/></td>
    <td class="odd"><input class="formButton" type="submit" value="<{$smarty.const._MD_XOONIPS_INDEX_BUTTON_REGISTER}>"/></td>
  </tr>
  <tr align="right">
    <td colspan="2"><a href="listitem.php?index_id=<{$xid}>"><{$smarty.const._MD_XOONIPS_ITEM_LISTING_ITEM}></a> | <a href="<{$xoops_url}>/"><{$smarty.const._MD_XOONIPS_LABEL_HOME}></a></td>
  </tr>
</table> 
</form>

<hr />
<{/if}>

<{if $child_indexes}>
<{if $write_permission}>
<h4><{$smarty.const._MD_XOONIPS_INDEX_TITLE_MODIFY}></h4>
<{if $childCount == 0 }>
<{$smarty.const._MD_XOONIPS_INDEX_NO_INDEX}>
<{else}>
<script type="text/javascript">
<!--
// if checkbox is on and rename is empty, process is error.
function canRename( button ){
    var form = button.form;
    var elements = form.elements;
    var elementsLen = elements.length;
    var i;
    var error = false;
    
    for ( i = 0; i < elementsLen; i++ ){
        var element = elements.item(i);
        if ( element.id.substring(0,13) == 'xoonipsCheck' && element.checked ){
            var xid = element.id.substring(13);
            var rename = document.getElementById('xoonipsRename' + xid);
            if ( rename != undefined ){
                if ( rename.value == "" ){
                    error = true;
                }
            }
        }
    }
    
    if ( error ){
        window.alert("<{$smarty.const._MD_XOONIPS_INDEX_NAME_CANNOT_BE_EMPTY}>");
    } else {
      form.op.value = 'rename';
      form.submit();
    }
}

function xoonipsUpDown( op, updown_xid ) {
	document.getElementById('xoonips_op').value = op;
	document.getElementById('xoonips_updown_xid').value = updown_xid;
	document.getElementById('xoonips_modify_form').submit();
	return false;
}

//-->
</script>
<form action="editindex.php" method="post" id="xoonips_modify_form"<{$accept_charset}>>
<{$token_ticket}>
<input type="hidden" name="index_id" value="<{$xid}>"/>
<input type="hidden" name="updown_xid" value="" id="xoonips_updown_xid"/>
<input type="hidden" name="op" value="" id="xoonips_op"/>
<table width="100%" border="0" cellspacing="5">
  <tr valign="top">
    <th></th>
    <th><{$smarty.const._MD_XOONIPS_INDEX_INDEX_KEYWORD}></th>
    <th><{$smarty.const._MD_XOONIPS_INDEX_RENAME_TO}></th>
    <th><{$smarty.const._MD_XOONIPS_INDEX_LABEL_UPDOWN}></th>
  </tr>
<{foreach item=index from=$child_indexes}>
  <tr valign="top" class="<{cycle values="even,odd" name="c0" }>">
    <td class="<{cycle values="even,odd" name="c1" }>">
      <{if !$index.isLocked}>
        <input type="checkbox" name="check[]" value="<{$index.item_id}>" id="xoonipsCheck<{$index.item_id}>"/>
      <{/if}>
    </td>
    <td class="<{cycle values="even,odd" name="c2" }>">
        <a href="editindex.php?index_id=<{$index.item_id}>"><{$index.titles[$smarty.const.DEFAULT_INDEX_TITLE_OFFSET]}></a>
    </td>
    <td class="<{cycle values="even,odd" name="c3" }>">
      <{if !$index.isLocked}>
        <input type="text" name="rename[<{$index.item_id}>]" size="25" id="xoonipsRename<{$index.item_id}>"/>
      <{else}>
        <span style='color: red;'><{$index.lockTypeString}></span>
      <{/if}>
    </td>
    <td class="<{cycle values="even,odd" name="c4" }>">
      <select name="steps[<{$index.item_id}>]">
      <{html_options options=$updown_options selected=1}>
      </select>
      <a href="#" onclick="return xoonipsUpDown('up',<{$index.item_id}>)"><{$smarty.const._MD_XOONIPS_INDEX_LABEL_UP}></a>
    / <a href="#" onclick="return xoonipsUpDown('down',<{$index.item_id}>)"><{$smarty.const._MD_XOONIPS_INDEX_LABEL_DOWN}></a></td>
  </tr>
<{/foreach}>
  <tr>
    <td><img src="images/arrow_ltr.png" alt="arrow"/></td>
    <td colspan="3">
      <table><tr>
      <td>
        <{$smarty.const._MD_XOONIPS_INDEX_LABEL_WITH_SELECTED}>
      </td>
      <td>
        <input class="formButton" type="button" value="<{$smarty.const._MD_XOONIPS_INDEX_BUTTON_RENAME}>" onclick="canRename(this)"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      </td>
      <td>
        <input class="formButton" type="button" value="<{$smarty.const._MD_XOONIPS_INDEX_BUTTON_DELETE}>" onclick="this.form.op.value='delete'; submit();"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      </td>
      <td>
        <input class="formButton" type="button" value="<{$smarty.const._MD_XOONIPS_INDEX_BUTTON_MOVETO}>" onclick="this.form.op.value='moveto'; submit();"/>
      </td>
      <td>
        <select name="moveto">
        <{foreach item=to from=$index_tree}>
        <option value="<{$to.item_id}>"><{$to.indent_html}><{$to.select_label}></option>
        <{/foreach}>
        </select>
      </td>
      </tr></table>
    </td>
  </tr>
</table>
</form>
<{/if}>

<table width="100%" border="0" cellspacing="5">
  <tr>
    <td align="right"><a href="listitem.php?index_id=<{$xid}>"><{$smarty.const._MD_XOONIPS_ITEM_LISTING_ITEM}></a> | <a href="<{$xoops_url}>/"><{$smarty.const._MD_XOONIPS_LABEL_HOME}></a></td>
  </tr>
</table>
<hr />
<{/if}>

<script type="text/javascript">

function add_input( form, name, value ){
  var node = document.createElement('INPUT');
  node.type = 'hidden'; node.name = name; node.value = value;
  form.appendChild(node);
  return node;
}

function submit_edit_form(){
  var form = document.getElementById('xoonips_modify_form');
  var sel = document.getElementById('add_to_index_id_sel');
  if ( form == null || sel == null )
    return;
  
  if ( !form.add_to_index_id ){ /* avoid doubling add_input() */
    form.action = 'editindex.php';
    form.method = 'post';
    var node = add_input( form, 'add_to_index_id', '' );
    add_input( form, 'op', 'add_to_public' );
    if ( !form.add_to_index_id )
      form.add_to_index_id = node;
  }
  form.add_to_index_id.value = sel.options[sel.selectedIndex].value;
  
  form.submit();
}

//-->
</script>

<{if $group_administrator==1}>
<{if $child_indexes}>
<h4><{$smarty.const._MD_XOONIPS_ITEM_GROUP_INDEX_TO_PUBLIC}></h4>
<{if $childCount == 0 }>
<{$smarty.const._MD_XOONIPS_INDEX_NO_INDEX}>
<{else}>
<form action="editindex.php" method="post" id="xoonips_modify_form"<{$accept_charset}>>
<{$token_ticket}>
<input type="hidden" name="index_id" value="<{$xid}>"/>
<input type="hidden" name="op" value="add_to_public" id="xoonips_op"/>
<table width="100%" border="0" cellspacing="5">
  <tr valign="top">
    <th></th>
    <th><{$smarty.const._MD_XOONIPS_INDEX_INDEX_KEYWORD}></th>
    <th colspan="2"><{$smarty.const._MD_XOONIPS_ITEM_INDEX_LABEL}></th>
  </tr>
<{foreach item=index from=$child_indexes}>
  <tr valign="top" class="<{cycle values="even,odd" name="c0" }>">
    <td class="<{cycle values="even,odd" name="c1" }>"><input type="checkbox" name="check[]" value="<{$index.item_id}>" id="xoonipsCheckGroupIndex<{$index.item_id}>"/></td>
    <td class="<{cycle values="even,odd" name="c2" }>"><a href="editindex.php?index_id=<{$index.item_id}>"><{$index.titles[$smarty.const.DEFAULT_INDEX_TITLE_OFFSET]}></a></td>
    <td class="<{cycle values="even,odd" name="c3" }>"><{$index.public_index_string}></td>
    <td class="<{cycle values="even,odd" name="c4" }>"><{$index.public_index_pending_string}></td>

  </tr>
<{/foreach}>
  <tr>
    <td><img src="images/arrow_ltr.png" alt="arrow"/></td>
    <td colspan="3">
      <table><tr>
      <td>
        <{$smarty.const._MD_XOONIPS_INDEX_LABEL_WITH_SELECTED}>
      </td>
      <td>
 <{$smarty.const._MD_XOONIPS_ADD_TO_PUBLIC_EXPLANATION}>
 <select name="add_to_index_id_sel">
 <{foreach item=to from=$public_index_tree}>
  <option value="<{$to.item_id}>"><{$to.indent_html}><{$to.select_label}></option>
 <{/foreach}>
 </select>
 <input class="formButton" type="submit" value="<{$smarty.const._MD_XOONIPS_ADD_TO_PUBLIC_LABEL}>" />
      </td>
      </tr></table>
    </td>
  </tr>
</table>
</form>
<{/if}>
<{/if}>

<table width="100%" border="0" cellspacing="5">
  <tr>
    <td align="right"><a href="listitem.php?index_id=<{$xid}>"><{$smarty.const._MD_XOONIPS_ITEM_LISTING_ITEM}></a> | <a href="<{$xoops_url}>/"><{$smarty.const._MD_XOONIPS_LABEL_HOME}></a></td>
  </tr>
</table>
<hr />

<{/if}>
<{/if}>
