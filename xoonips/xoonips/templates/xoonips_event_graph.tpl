<{* page for download event logs *}>
<{* $Revision: 1.2.2.1.2.1 $ *}>

<{include file="db:xoonips_breadcrumbs.inc.tpl"}>

<div style="text-align: center; margin: 10px;">
 <img src="event_log.php?mode=graph&amp;log_type_id=<{$log_type_id}>&amp;StartDate=<{$start_time}>&amp;EndDate=<{$end_time}>" alt="Graph of Event Logs (ID:<{$log_type_id}> Time:<{$start_time}>-<{$end_time}>)" />
</div>
