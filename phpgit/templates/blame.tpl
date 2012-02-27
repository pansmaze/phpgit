{*
 * blame.tpl
 * gitphp: A PHP git repository browser
 * Component: Blame view template
 *
 * Copyright (C) 2010 Christopher Han <xiphux@gmail.com>
 *}
{include file='header.tpl'}

 <div class="page_nav">
   {include file='nav.tpl' treecommit=$commit}
   <div class="sub_nav">
   <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=blob_plain&amp;h={$blob->GetHash()}&amp;f={$blob->GetPath()}{if $branch_name}&amp;bn={$branch_name}{/if}">{t}plain{/t}</a> &sdot; 
   {if $commit->GetHash() != $head->GetHash()}
     <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=blame&amp;hb=HEAD&amp;f={$blob->GetPath()}{if $branch_name}&amp;bn={$branch_name}{/if}">{t}HEAD{/t}</a>
   {else}
     <span>{t}HEAD{/t}</span>
   {/if}
    &sdot; <span>blame</span>
   </div>
 </div>

 {include file='title.tpl' titlecommit=$commit}

 {include file='path.tpl' pathobject=$blob target='blob'}
 
 <div class="page_body">
   {if $geshi}
     {$geshihead}
       <td class="ln de1" id="blameData">
        {include file='blamedata.tpl'}
       </td>
     {$geshibody}
     {$geshifoot}
   {else}
 	<table class="code">
	{foreach from=$blob->GetData(true) item=blobline name=blob}
	  {assign var=blamecommit value=$blame[$smarty.foreach.blob.iteration]}
	  {if $blamecommit}
	    {cycle values="light,dark" assign=rowclass}
	  {/if}
	  <tr class="{$rowclass}">
	    <td class="date">
	      {if $blamecommit}
	        <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=commit&amp;h={$blamecommit->GetHash()}" title="{$blamecommit->GetTitle()|escape:'html'}" class="commitTip">{$blamecommit->GetAuthorEpoch()|date_format:"%Y-%m-%d %H:%M:%S"}</a>
	      {/if}
	    </td>
	    <td class="author">
	      {if $blamecommit}
	        {$blamecommit->GetAuthor()}
	      {/if}
	    </td>
	    <td class="num"><a id="l{$smarty.foreach.blob.iteration}" href="#l{$smarty.foreach.blob.iteration}" class="linenr">{$smarty.foreach.blob.iteration}</a></td>
	    <td class="codeline">{$blobline|escape}</td>
	  </tr>
	{/foreach}
	</table>
  {/if}
 </div>

 {include file='footer.tpl'}
