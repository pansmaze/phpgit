{*
 * Headlist
 *
 * Head list template fragment
 *
 * @author Christopher Han <xiphux@gmail.com>
 * @copyright Copyright (c) 2010 Christopher Han
 * @packge GitPHP
 * @subpackage Template
 *}
{assign var=hcount value=$headlist|@count}
<div class="altogether_num">{$hcount} branch{if $hount!=1}es{/if} is found</div>
{* <table cellspacing="0">
   * Loop and display each head *
   {foreach from=$headlist item=head name=heads}
       {assign var=headcommit value=$head->GetCommit()}
       <tr class="{cycle values="light,dark"}">
         <td><em>{$headcommit->GetAge()|agestring}</em></td>
         <td><a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=shortlog&amp;h=refs/heads/{$head->GetName()}" class="list"><strong>{$head->GetName()}</strong></a></td>
         <td class="link"><a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=shortlog&amp;h=refs/heads/{$head->GetName()}">{t}shortlog{/t}</a> | <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=log&amp;h=refs/heads/{$head->GetName()}">{t}log{/t}</a> | <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=tree&amp;hb={$headcommit->GetHash()}&amp;bn={$head->GetName()}">{t}tree{/t}</a></td>
       </tr>
   {/foreach}
   {if $hasmoreheads}
       <tr>
       <td><a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=heads">&hellip;</a></td>
       </tr>
   {/if}
 </table>*}
<ul class="branchList">
	{foreach from=$headlist item=head name=heads}
	{assign var=headcommit value=$head->GetCommit()}
	<li{if $branch_name==$head->GetName()} class="current"{/if}>
		<a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=tree&amp;hb={$headcommit->GetHash()}&amp;bn={$head->GetName()}" class="bname"><strong>{$head->GetName()}</strong></a>
		<a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=log&amp;hb={$headcommit->GetHash()}&amp;bn={$head->GetName()}" class="bhash">commit:{$head->GetHash()|truncate:'10':''}</a>
		<span class="log">{$headcommit->GetTitle()|escape:'html'}</span>
		<span class="time_and_author">[{$headcommit->GetAuthorName()}]&nbsp;&nbsp;
		{assign var=this_age value=$headcommit->GetAge()}
		{if $this_age < 7200}   {* 60*60*2, or 2 hours *}
	            <span class="agehighlight"><strong><em>{$this_age|agestring}</em></strong></span>
        	{elseif $this_age < 172800}   {* 60*60*24*2, or 2 days *}
	            <span class="agehighlight"><em>{$this_age|agestring}</em></span>
        	{else}
        	    <em>{$this_age|agestring}</em>
          	{/if}
		</span>
	</li>
	{/foreach}
</ul>

