{*
 *  blob.tpl
 *  gitphp: A PHP git repository browser
 *  Component: Blob view template
 *
 *  Copyright (C) 2009 Christopher Han <xiphux@gmail.com>
 *}
{include file='header.tpl'}

 <div class="page_nav">
   {include file='nav.tpl' treecommit=$commit current='tree'}
    </div>

 {include file='title.tpl' titlecommit=$commit}

{include file='path.tpl' pathobject=$blob target='no_link'}

 <div class="page_body">
   <div class="browser_wrapper">
   <div class="sub_nav">
   <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=blob_plain&amp;h={$blob->GetHash()}&amp;f={$blob->GetPath()}{if $branch_name}&amp;bn={$branch_name}{/if}">{t}raw{/t}</a> 
   {*if ($commit->GetHash() != $head->GetHash()) && ($head->PathToHash($blob->GetPath()))}
     <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=blob&amp;hb=HEAD&amp;f={$blob->GetPath()}{if $branch_name}&amp;bn={$branch_name}{/if}">{t}HEAD{/t}</a>
   {else}
     <span>{t}HEAD{/t}</span>
   {/if*}
   {if $blob->GetPath()}
    <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=log&amp;hb={$commit->GetHash()}&amp;f={$blob->GetPath()}&amp;ftype=blob{if $branch_name}&amp;bn={$branch_name}{/if}">{t}history{/t}</a>
   {if !$datatag} <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=blame&amp;h={$blob->GetHash()}&amp;f={$blob->GetPath()}&amp;hb={$commit->GetHash()}{if $branch_name}&amp;bn={$branch_name}{/if}" id="blameLink">{t}blame{/t}</a>{/if}
   {/if}
   </div>
<div class="browser">
   {if $datatag}
     {* We're trying to display an image *}
     <div id="imageData">
       <img src="data:{$mime};base64,{$data}" />
     </div>
   {elseif $geshi}
     {* We're using the highlighted output from geshi *}
     {$geshiout}
   {else}
     {* Just plain display *}
<table class="code" id="blobData" cellspacing="0" cellpadding="0">
<tbody>
<tr class="li1">
<td class="ln">
<pre class="de1">
{foreach from=$bloblines item=line name=bloblines}
<span id="l{$smarty.foreach.bloblines.iteration}" class="linenr">{$smarty.foreach.bloblines.iteration}</span>
{/foreach}
</pre></td>
<td class="de1">
<pre class="de1">
{foreach from=$bloblines item=line name=bloblines}
{$line|escape}
{/foreach}
</pre>
</td>
</tr>
</tbody>
</table>
   {/if}
</div>
</div>
 </div>

 {include file='footer.tpl'}
