{if $revlist|@count==0}
No commits record...
{else}
{assign var=cycle_param value=0}
{assign var=date_cursor value=$revlist[0]->GetAuthorEpoch()|date_format:"%Y.%m.%d"}
<div class="commit_box">
	<div class="commit_box_title">{$date_cursor}</div>
{foreach from=$revlist item=rev}
{assign var=revtree value=$rev->GetTree()}
{if $revtree}
{assign var=current_cursor value=$rev->GetAuthorEpoch()|date_format:"%Y.%m.%d"}
{if $current_cursor!=$date_cursor}
{assign var=cycle_param value=0}
</div>
<div class="commit_box">
	<div class="commit_box_title">{$current_cursor}</div>
{assign var=date_cursor value=$current_cursor}
{/if}
<div class="commit_record {if $cycle_param%2==0}light{else}dark{/if}">
	<div class="ctrl_pane">
		<input type="checkbox"/><span class="select_to_compare" data-hash="{$rev->GetHash()}">Select</span>
		<a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=tree&amp;h={$revtree->GetHash()}&amp;hb={$rev->GetHash()}">{t}Tree{/t}</a>
	</div>
     	<a title="view commit details" href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=commitdiff&amp;hb={$rev->GetHash()}&amp;h={$rev->GetHash()}{if $branch_name}&amp;bn={$branch_name}{/if}" class="commit_title">{$rev->GetTitle()|escape:'html'}</a>
     {include file='refbadges.tpl' commit=$rev}
     	{if count($rev->GetComment()) > 1}
	<span class="show_comment">&nbsp;</span>
	<div class="comment">
		{assign var=bugpattern value=$project->GetBugPattern()}
		{assign var=bugurl value=$project->GetBugUrl()}
		{foreach from=$rev->GetComment() item=line}
			{if $line!=$rev->GetTitle()}
			{$line|htmlspecialchars|buglink:$bugpattern:$bugurl}<br />
			{/if}
		{/foreach}
     		{if count($rev->GetComment()) > 0}
       		<br />
     		{/if}
	</div>
	{/if}
	<div class="author_info">[{$rev->GetAuthorName()}] {$rev->GetAuthorEpoch()|date_format:"%Y-%m-%d %H:%m:%S"}&nbsp;&nbsp;&nbsp;commit:<a title="{$rev->GetHash()}" href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=commitdiff&amp;h={$rev->GetHash()}&amp;hb={$rev->GetHash()}">{$rev->GetHash()|truncate:'10':''}</a></div>
</div>
{/if}
{assign var=cycle_param value=$cycle_param+1}
{/foreach}
</div>
{/if}
<script type="text/javascript">
var HASMOREREVS = {if $hasmorerevs}true{else}false{/if};
</script>
