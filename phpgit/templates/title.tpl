{*
 * Title
 *
 * Title template
 *
 * @author Christopher Han <xiphux@gmail.com>
 * @copyright Copyright (c) 2010 Christopher Han
 * @package GitPHP
 * @subpackage Template
 *}
{if !$diffpage}
<div class="ref_commit_title">
	{if $current_hashbase}Browsing ref <span title="{$current_hashbase}">{$current_hashbase|truncate:'10':''}</span>&nbsp;&nbsp;&nbsp;{else}Latest commit to the <span>{$branch_name}</span> branch{/if}
</div>
{/if}
<div class="title">
	{if $titlecommit}
		{if $target == 'commitdiff'}
			<a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=commitdiff&amp;h={$titlecommit->GetHash()}{if $branch_name}&amp;bn={$branch_name}{/if}" class="title">{$titlecommit->GetTitle()|escape:'html'}</a>
		{elseif $target == 'tree'}
			<a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=tree&amp;h={$titletree->GetHash()}&amp;hb={$titlecommit->GetHash()}{if $branch_name}&amp;bn={$branch_name}{/if}" class="title">{$titlecommit->GetTitle()|escape:'html'}</a>
		{else}
			<a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=commit&amp;h={$titlecommit->GetHash()}{if $branch_name}&amp;bn={$branch_name}{/if}" class="title">{$titlecommit->GetTitle()|escape:'html'}</a>
		{/if}
		{if $diffpage}
		<a class="view_tree_link" href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=tree&amp;h={$tree->GetHash()}&amp;hb={$titlecommit->GetHash()}">{t}Tree{/t}</a>
		{else}
		{*include file='refbadges.tpl' commit=$titlecommit*}
		{/if}
		<div class="commit_info">
			commit&nbsp;
			{*<span class="commit_time" title="{if $titlecommit->GetAge() > 60*60*24*7*2}{$titlecommit->GetAge()|agestring}{else}{$titlecommit->GetCommitterEpoch()|date_format:"%Y-%m-%d"}{/if}">
				{if $titlecommit->GetAge() > 60*60*24*7*2}{$titlecommit->GetCommitterEpoch()|date_format:"%Y-%m-%d"}{else}{$titlecommit->GetAge()|agestring}{/if}
			</span>*}
			<span class="commit_time" title="{$titlecommit->GetCommitterEpoch()|date_format:"%Y-%m-%d %H:%m:%S"}">
				{$titlecommit->GetCommitterEpoch()|date_format:"%Y-%m-%d"}
			</span>
			{if $hashnolink}
			<span title="{$titlecommit->GetHash()}">{$titlecommit->GetHash()|truncate:'10':''}</span>
			{else}
				{if $diffpage}
				<span title="{$titlecommit->GetHash()}">{$titlecommit->GetHash()|truncate:'10':''}</span>
				{else}
				<a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=commitdiff&amp;h={$titlecommit->GetHash()}{if $param_hb}&amp;hb={$param_hb}{/if}" title="{$titlecommit->GetHash()}">{$titlecommit->GetHash()|truncate:'10':''}</a>
				{/if}
			{/if}
			{if $diffpage}
			&nbsp;&nbsp;
			<span class="commit_parents">
				{assign var=commit_parents value=$titlecommit->GetParents()}
				{assign var=cp_count value=$commit_parents|@count}
				{$cp_count} parent{if $cp_count!=1}s{/if}
				{foreach from=$commit_parents item=cp}
					<a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=commitdiff&amp;h={$cp->GetHash()}{if $param_hb}&amp;hb={$param_hb}{/if}" title="{$cp->GetHash()}">{$cp->GetHash()|truncate:'10':''}</a>
					{assign var=cp_count value=$cp_count-1}
					{if $cp_count!=0}
						+
					{/if}
				{/foreach}
			</span>
			{/if}
      			<span class="author_name">[{$titlecommit->GetAuthorName()}]</span>
		</div>
	{else}
		{if $target == 'summary'}
			<a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=summary{if $branch_name}&amp;bn={$branch_name}{/if}" class="title">&nbsp;</a>
		{elseif $target == 'shortlog'}
			{if $disablelink}
			  {t}shortlog{/t}
			{else}
			  <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=shortlog{if $branch_name}&amp;bn={$branch_name}{/if}" class="title">{t}shortlog{/t}</a>
			{/if}
		{elseif $target == 'tags'}
			{if $disablelink}
			  {t}tags{/t}
			{else}
			  <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=tags{if $branch_name}&amp;bn={$branch_name}{/if}" class="title">{t}tags{/t}</a>
			{/if}
		{elseif $target == 'heads'}
			{if $disablelink}
			  {t}heads{/t}
			{else}
			  <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=heads{if $branch_name}&amp;bn={$branch_name}{/if}" class="title">{t}heads{/t}</a>
			{/if}
		{else}
			&nbsp;
		{/if}
	{/if}
</div>
