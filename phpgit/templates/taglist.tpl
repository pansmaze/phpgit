{*
 * Taglist
 *
 * Tag list template fragment
 *
 * @author Christopher Han <xiphux@gmail.com>
 * @copyright Copyright (c) 2010 Christopher Han
 * @packge GitPHP
 * @subpackage Template
 *}
{assign var=tcount value=$taglist|@count}
<div class="altogether_num">{$tcount} Tag{if $tcount!=1&&$tcount!=0}s{/if}:</div>

{* <table cellspacing="0" class="tagTable">
   {foreach from=$taglist item=tag name=tag}
     <tr class="{cycle name=tags values="light,dark"}">
	   {assign var=object value=$tag->GetObject()}
	   {assign var=tagcommit value=$tag->GetCommit()}
	   {assign var=objtype value=$tag->GetType()}
           <td><em>{if $tagcommit}{$tagcommit->GetAge()|agestring}{else}{$tag->GetAge()|agestring}{/if}</em></td>
           <td>
	   {if $objtype == 'commit'}
		   <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=commit&amp;h={$object->GetHash()}" class="list"><strong>{$tag->GetName()}</strong></a>
	   {elseif $objtype == 'tag'}
		   <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=tag&amp;h={$tag->GetName()}" class="list"><strong>{$tag->GetName()}</strong></a>
	   {elseif $objtype == 'blob'}
		   <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=tag&amp;h={$tag->GetName()}" class="list"><strong>{$tag->GetName()}</strong></a>
	   {/if}
	   </td>
           <td>
	     {assign var=comment value=$tag->GetComment()}
             {if count($comment) > 0}
               <a class="list {if !$tag->LightTag()}tagTip{/if}" href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=tag&amp;h={$tag->GetName()}">{$comment[0]}</a>
             {/if}
           </td>
           <td class="link">
*             {if !$tag->LightTag()}
   	       <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=tag&amp;h={$tag->GetName()}">{t}tag{/t}</a> | 
             {/if}
	     {if $objtype == 'blob'}
		<a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=blob&amp;h={$object->GetHash()}">{t}blob{/t}</a>
	     {else}
             <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=commit&amp;h={$tagcommit->GetHash()}">{t}commit{/t}</a>
	      | <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=shortlog&amp;h={$tagcommit->GetHash()}">{t}shortlog{/t}</a> | <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=log&amp;h={$tagcommit->GetHash()}">{t}log{/t}</a> | <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=snapshot&amp;h={$tagcommit->GetHash()}" class="snapshotTip">{t}snapshot{/t}</a>
	      {/if}
*
		<a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=log&amp;h={$tagcommit->GetHash()}">{t}Commits{/t}</a>
           </td>
       </tr>
     {/foreach}
     {if $hasmoretags}
       <tr>
         <td><a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=tags">&hellip;</a></td>
       </tr>
     {/if}
   </table>*}

<ul class="tagList">
   {foreach from=$taglist item=tag name=tag}
	   {assign var=object value=$tag->GetObject()}
	   {assign var=tagcommit value=$tag->GetCommit()}
	   {assign var=tp value=$tagcommit->GetParent()}
	<li>
		<a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=commitdiff&amp;h={$tagcommit->GetHash()}&amp;hp={$tp->GetHash()}" class="tname"><strong>{$tag->GetName()}</strong></a>
     		<a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=snapshot&amp;h={$tagcommit->GetHash()}&amp;fmt=tar" class="snapshot_link">tar</a>
     		<a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=snapshot&amp;h={$tagcommit->GetHash()}&amp;fmt=zip" class="snapshot_link">zip</a>
     		<a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=snapshot&amp;h={$tagcommit->GetHash()}&amp;fmt=tgz" class="snapshot_link">tar.gz</a>
		<span class="submit_time">[{$tagcommit->GetAuthorName()}]&nbsp;&nbsp;{$tagcommit->GetCommitterEpoch()|date_format:"%Y-%m-%d %H:%m:%S"}</span>
	</li>
   {/foreach}
</ul>
