{*
 * Pconf
 *
 * Projects config template
 *
 * @author Shiyan.zyj <shiyan.zyj@taobao.com>
 * @copyright Copyright (c) 2012 Shiyan.zyj
 * @package GitPHP
 * @subpackage Template
 *}

{include file='header.tpl'}
<div>
	<h3>project conf main page</h3>
	<p><a href="{$SCRIPT_NAME}?a=pconf&action=add" target-"_blank">add new project</a></p>
	{foreach from=$plist item=project}
	<hr/>
	<h4>{$project.name|escape:'html'}</h4>
	<div data-id="{$project.id}" class="project">
		{foreach from=$project key=feild item=val}
		{if $feild!='id'}
		<p><label class="feild">{$feild}</label>:<span class="value">{$val|escape:'html'}</span></p>
		{/if}
		{/foreach}
		<input type="button" class="delete_project" style="float:right;color:red;cursor:pointer;margin-top:-10px;" data-pid="{$project.id}" value="delete!" />
		<a href="{$SCRIPT_NAME}?a=pconf&action=edit&id={$project.id}" target="_blank">edit this one</a>
	</div>
	{/foreach}
</div>
<script>
var SNAME = "{$SCRIPT_NAME}", P_ID = "{$project.id}";
{literal}
$(function(){
	$(".delete_project").click(function(){
		if (confirm('确定真的要删除么？此删除不可恢复！！')) {
			$.ajax({
				url: SNAME + "?a=project/delete",
				type: "POST",
				dataType: "json",
				data: {id: P_ID},
				success: function(data){
					if (data.rst) {
						$("div[data-id]=" + P_ID).remove();
						alert('deleted success!');
					} else {
						alert("deleted fail!");
					}
				},
				error: function(data) {
					alert("operation fail!");
				}
			});
		}
	});
});
</script>
{/literal}
{include file='footer.tpl'}
