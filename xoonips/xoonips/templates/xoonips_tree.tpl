<link rel="stylesheet" type="text/css" href="style.css" />
<script type="text/javascript" src="js/xoonips_treelib.js">
</script>
<script type="text/javascript" src="js/xoonips_tree.js">
</script>
<script type="text/javascript">
<!--
var xoonips_tree_cookie = new XooNIpsTreeJS.Cookie( false, false, 0, false );
var xoonips_tree_tab_control = new XooNIpsTreeJS.TabControl( xoonips_tree_cookie, 'xoonipsTab', 'xoonipsOpenTab', 'xoonipsSelectedTab2', 'xoonipScroll' );
var xoonips_tree_attributes = new XooNIpsTreeJS.Attributes();
var xoonips_tree = new XooNIpsTreeJS.Tree( xoonips_tree_cookie, xoonips_tree_tab_control, xoonips_tree_attributes, 'xoonipsTreeHere', 'hiddenCheckHere', 'xoonipsOpenState2', 'xoonipsCheckState2', 'xoonipsCheckedXID' );

<{foreach item=node from=$tree_nodes}>
xoonips_tree.registerNode( < {$node.xid
}>, <
{
    $node.child
}
>, <
{
    $node.open_level
}
>, <
{
    $node.is_last
}
>,
"<{$node.title}>"
)
<{/foreach}>
<{foreach item=root from=$tree_roots}>
xoonips_tree.registerRoot( < {$root} >
)
<{/foreach}>
<{foreach item=attrib from=$tree_attribs}>
xoonips_tree_attributes.setAttribute( '<{$attrib.key}>', '<{$attrib.value}>' );
<{/foreach}>

function onLoad(){
  xoonips_tree.initialize();
}

function onUnload(){
  xoonips_tree.finalize();
}

// register private checkbox callback handler
var xoonips_oncheck_private_handler_id='<{$oncheck_private_handler_id}>';
var xoonips_check_private_count = 0;
function xoonips_onclick_private_checkbox( is_checked ) {
  if ( is_checked ) {
    xoonips_check_private_count++;
  } else {
    xoonips_check_private_count -= 1;
  }
  if ( xoonips_oncheck_private_handler_id ) {
    var stub = window.top.document.getElementById( xoonips_oncheck_private_handler_id );
    if ( stub != null ) {
      if ( typeof( stub.onCheckPrivate ) == 'function' ) {
        var has_private = ( 0 < xoonips_check_private_count );
        stub.onCheckPrivate( has_private );
      } else {
        alert( 'onCheckPrivate function not defined' );
      }
    } else {
      alert( 'element id not found' );
    }
  }
  return true;
}
xoonips_tree.registerCheckboxCallback( 'private', xoonips_onclick_private_checkbox );

//-->
</script>
</head>
<body onload="onLoad();" onunload="onUnload();" style="padding: 0;">
<form action="javascript:void(0);">
<div class="directory" id="xoonipsTreeHere">
</div>
<div id="hiddenCheckHere" style="display: none;">
</div>
</form>
