<{foreach item=preview from=$previews}>
<div class="xoonips_detail_preview_<{cycle values="left,center,right"}>">
  <a href="<{$preview.image_url}>" target="_blank">
    <img src="<{$preview.thumbnail_url}>" alt="<{$preview.caption}>"/>
  </a><br>
  <{$preview.caption}>
</div>
<{/foreach}>
