<{*
assign( 'vars', array(
    'table_name' => 'xnppaper_author',
    'name' => array(
        'primary_key' => '',
        'text' => '',
        'order' => '' ),
    'objects' => array(
        'primary_key' => array(
            'name' => 'paper_author_id',
            'value' => '100' ),
        'text' => array(
            'name' => 'author',
            'within' => 'foo', //option
            'without' => 'bar', //option
            'value' => 'foobar' ),
        'order' => array(
            'name' => 'author_order',
            'value' => '0' )
      )..,
    'num' => '5', // number of objects
  )
);
*}>
<script type="text/javascript">
var <{$vars.table_name}> = new XooNIpsItemEditJS.MultipleField( '<{$vars.table_name}>', '<{$vars.name.text}>', '<{$vars.name.primary_key}>', '<{$vars.name.order}>' );
<{*
// customize icon and label for XooNIpsItemEditJS.MultipleField class
// - default icon size is 16x16
<{$vars.table_name}>.icon_delete = './images/icon_delete.png';
<{$vars.table_name}>.icon_up = './images/icon_up.png';
<{$vars.table_name}>.icon_down = './images/icon_down.png';
<{$vars.table_name}>.icon_blank = './images/icon_blank.png';
<{$vars.table_name}>.label_delete = 'DELETE';
<{$vars.table_name}>.label_up = 'UP';
<{$vars.table_name}>.label_down = 'DOWN';
<{$vars.table_name}>.label_blank = '';
*}>
</script>
<div id="<{$vars.table_name}>_container">
<{foreach item="var" key="order" from=$vars.objects name="objects"}>
  <div style="white-space: nowrap;" id="<{$vars.table_name}>_<{$order}>">
    <input type="text" id="<{$vars.table_name}>_<{$order}>_<{$vars.name.text}>" name="<{$vars.table_name}>[<{$order}>][<{$vars.name.text}>]" value="<{$var.text.value}>" style="ime-mode:active;" size="50"/>
      <a href="javascript:void(0);" onclick="<{$vars.table_name}>.deleteField(<{$order}>)return false;"><img alt="DELETE" title="DELETE"
                                                                                                             src="./images/icon_delete.png"/></a>
      <{if $smarty.foreach.objects.first}>

    <a href="javascript:void(0);" onclick="<{$vars.table_name}>.upField(<{$order}>)return false;"><img id="<{$vars.table_name}>_<{$order}>_image_up"
                                                                                                         alt="" title=""
                                                                                                         src="./images/icon_blank.png"/></a>
      <{else}>

    <a href="javascript:void(0);" onclick="<{$vars.table_name}>.upField(<{$order}>)return false;"><img id="<{$vars.table_name}>_<{$order}>_image_up"
                                                                                                         alt="UP" title="UP"
                                                                                                         src="./images/icon_up.png"/></a>
      <{/if}>
<{if $smarty.foreach.objects.last}>

    <a href="javascript:void(0);" onclick="<{$vars.table_name}>.downField(<{$order}>)return false;"><img
              id="<{$vars.table_name}>_<{$order}>_image_down" alt="" title="" src="./images/icon_blank.png"/></a>
      <{else}>

    <a href="javascript:void(0);" onclick="<{$vars.table_name}>.downField(<{$order}>)return false;"><img
              id="<{$vars.table_name}>_<{$order}>_image_down" alt="DOWN" title="DOWN" src="./images/icon_down.png"/></a>
      <{/if}>
    <input type="hidden" id="<{$vars.table_name}>_<{$order}>_<{$vars.name.primary_key}>" name="<{$vars.table_name}>[<{$order}>][<{$vars.name.primary_key}>]" value="<{$var.primary_key.value}>"/>
    <input type="hidden" id="<{$vars.table_name}>_<{$order}>_<{$vars.name.order}>" name="<{$vars.table_name}>[<{$order}>][<{$vars.name.order}>]" value="<{$var.order.value}>"/>
  </div>
<{/foreach}>
</div>
<input type="button" class="formButton" value="<{$smarty.const._MD_XOONIPS_MULTIPLE_FIELD_ADD_LABEL}>" onclick="<{$vars.table_name}>.appendField();"/>
<input type="hidden" id="<{$vars.table_name}>_num" value="<{$vars.num}>"/>
