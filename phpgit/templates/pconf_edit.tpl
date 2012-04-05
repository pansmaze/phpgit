{*
 * Pconf_edit
 *
 * Edit a Project config template
 *
 * @author Shiyan.zyj <shiyan.zyj@taobao.com>
 * @copyright Copyright (c) 2012 Shiyan.zyj
 * @package GitPHP
 * @subpackage Template
 *}

{include file='header.tpl'}
<div class="input_form">
	{if $p_info}
	<form action="{$SCRIPT_NAME}?a=project/edit" method="post">
		{foreach from=$p_info item=val key=key}
		{if $key=='id'}
			<input type="hidden" value="{$val}" name="id" />
		{else}
			{if $key|strrpos:'|'}
				{assign var=display_key value='|'|explode:$key}
				{assign var=key value=$display_key.0}
				{assign var=display_key value=$display_key.1}
			{else}
				{assign var=display_key value=$key}
			{/if}
			<p>
				<label>{$display_key}</label>:
				{if 'charset'==$key}
				<select name="charset">
					<option value="utf-8"{if 'utf-8'==$val} selected="selected"{/if}>utf-8</option>
					<option value="GBK"{if 'utf-8'==$val} selected="selected"{/if}>GBK</option>
				</select>
				{else}
				<input name="{$key}" type="text" value="{$val}" />
				{/if}
			</p>
		{/if}
		{/foreach}
		<input type="submit" value="submit" />
	</form>
	{else}
	There is no this project, check the pid({$p_id})!
	{/if}
</div>
{include file='footer.tpl'}
