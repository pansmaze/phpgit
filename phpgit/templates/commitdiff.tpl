{*
 *  commitdiff.tpl
 *  gitphp: A PHP git repository browser
 *  Component: Commitdiff view template
 *
 *  Copyright (C) 2009 Christopher Han <xiphux@gmail.com>
 *}
{include file='header.tpl'}

 {* Nav *}
 <div class="page_nav">
   {if $commit}
   {assign var=tree value=$commit->GetTree()}
   {/if}
   {include file='nav.tpl' current='log' logcommit=$commit treecommit=$commit bs_noneed=true}
{*   <br />
   {if $sidebyside}
   <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=commitdiff&amp;h={$commit->GetHash()}{if $hashparent}&amp;hp={$hashparent}{/if}&amp;o=unified">{t}unified{/t}</a>
   {else}
   <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=commitdiff&amp;h={$commit->GetHash()}{if $hashparent}&amp;hp={$hashparent}{/if}&amp;o=sidebyside">{t}side by side{/t}</a>
   {/if}
   | <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=commitdiff_plain&amp;h={$commit->GetHash()}{if $hashparent}&amp;hp={$hashparent}{/if}">{t}plain{/t}</a>
*}
 </div>

 {include file='title.tpl' titlecommit=$commit diffpage=true}
 
 <div class="page_body">
   {assign var=bugpattern value=$project->GetBugPattern()}
   {assign var=bugurl value=$project->GetBugUrl()}
   {*foreach from=$commit->GetComment() item=line}
     {$line|htmlspecialchars|buglink:$bugpattern:$bugurl}<br />
   {/foreach*}
   <br />

   {if $sidebyside && ($treediff->Count() > 1)}
    <div class="commitDiffSBS">

     <div class="SBSTOC">
       <ul>
       <li class="listcount">
       {t count=$treediff->Count() 1=$treediff->Count() plural="%1 files changed:"}%1 file changed:{/t} <a href="#" class="showAll">{t}(show all){/t}</a></li>
       {foreach from=$treediff item=filediff}
       <li>
       <a href="#{$filediff->GetFromHash()}_{$filediff->GetToHash()}" class="SBSTOCItem">
       {if $filediff->GetStatus() == 'A'}
         {if $filediff->GetToFile()}{$filediff->GetToFile()}{else}{$filediff->GetToHash()}{/if} {t}(new){/t}
       {elseif $filediff->GetStatus() == 'D'}
         {if $filediff->GetFromFile()}{$filediff->GetFromFile()}{else}{$filediff->GetToFile()}{/if} {t}(deleted){/t}
       {elseif $filediff->GetStatus() == 'M'}
         {if $filediff->GetFromFile()}
	   {assign var=fromfilename value=$filediff->GetFromFile()}
	 {else}
	   {assign var=fromfilename value=$filediff->GetFromHash()}
	 {/if}
	 {if $filediff->GetToFile()}
	   {assign var=tofilename value=$filediff->GetToFile()}
	 {else}
	   {assign var=tofilename value=$filediff->GetToHash()}
	 {/if}
	 {$fromfilename}{if $fromfilename != $tofilename} -&gt; {$tofilename}{/if}
       {/if}
       </a>
       </li>
       {/foreach}
       </ul>
     </div>

     <div class="SBSContent">
   {/if}

   {* Diff each file changed *}
<div class="files_num_changed">
	{assign var=file_num value=$treediff->count()}
	{$file_num} File{if $file_num!=1}s{/if} Changed
</div>
   {foreach from=$treediff item=filediff}
     {if $filediff->GetToFileType()!='directory'&&$filediff->GetFromFileType()!='directory'}
     <div class="diffBlob" id="{$filediff->GetFromHash()}_{$filediff->GetToHash()}">
	{assign var=file_status value=$filediff->GetStatus()}
     <div class="diff_info type{$file_status}">
	[{$file_status|strtoupper}]&nbsp;
	{if $file_status=='R'}
		{if $filediff->GetFromFile()}/{$filediff->GetFromFile()}{else}{$filediff->GetFromHash()}{/if}&nbsp;&gt;&nbsp;
	{else}
		{if $filediff->GetToFile()}/{$filediff->GetToFile()}{else}{$filediff->GetToHash()}{/if}
	{/if}
	<a href="javascript:void(0)" class="hint"><span></span></a>
<a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=blob&amp;h={$filediff->GetToHash()}&amp;hb={$commit->GetHash()}{if $filediff->GetToFile()}&amp;f={$filediff->GetToFile()}{/if}" class="view_file_link">{t}File{/t}</a>

{*     {if ($filediff->GetStatus() == 'D') || ($filediff->GetStatus() == 'M')}
       {assign var=localfromtype value=$filediff->GetFromFileType(1)}
       {$localfromtype}:<a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=blob&amp;h={$filediff->GetFromHash()}&amp;hb={$commit->GetHash()}{if $filediff->GetFromFile()}&amp;f={$filediff->GetFromFile()}{/if}">{if $filediff->GetFromFile()}a/{$filediff->GetFromFile()}{else}{$filediff->GetFromHash()}{/if}</a>
       {if $filediff->GetStatus() == 'D'}
         {t}(deleted){/t}
       {/if}
     {/if}

     {if $filediff->GetStatus() == 'M'}
       -&gt;
     {/if}

     {if ($filediff->GetStatus() == 'A') || ($filediff->GetStatus() == 'M')}
       {assign var=localtotype value=$filediff->GetToFileType(1)}
       {$localtotype}:<a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=blob&amp;h={$filediff->GetToHash()}&amp;hb={$commit->GetHash()}{if $filediff->GetToFile()}&amp;f={$filediff->GetToFile()}{/if}">{if $filediff->GetToFile()}b/{$filediff->GetToFile()}{else}{$filediff->GetToHash()}{/if}</a>

       {if $filediff->GetStatus() == 'A'}
         {t}(new){/t}
       {/if}
     {/if}      *}
     </div>
     {if $sidebyside}
        {include file='filediffsidebyside.tpl' diffsplit=$filediff->GetDiffSplit()}
     {else}
        {include file='filediff.tpl' diff=$filediff->GetDiff('', true, true)}
     {/if}
     </div>
     {/if}
   {/foreach}

   {if $sidebyside && ($treediff->Count() > 1)}
     </div>
     <div class="SBSFooter"></div>

    </div>
   {/if}


 </div>
{literal}
<script type="text/javascript">
	$(document).ready(function(){
		$(".hint").click(function(){
			$(this).toggleClass("clicked");
			$(this).parent().next().slideToggle(250);
		});
		$(".hint:first").addClass("clicked").parent().next().show();
	});
</script>
{/literal}

 {include file='footer.tpl'}

