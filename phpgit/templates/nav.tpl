{*
 * Nav
 *
 * Nav links template fragment
 *
 * @author Christopher Han <xiphux@gmail.com>
 * @copyright Copyright (c) 2010 Christopher Han
 * @package GitPHP
 * @subpackage Template
 *}
   {if $branch_list&&!$bs_noneed}
    <!--Current Ref：&nbsp;-->
      <select id="branch_selector">
	{if $current_hashbase}<option value="{$current_hashbase}" selected="selected">{$current_hashbase|truncate:'10':''}</option>{/if}
       {foreach from=$branch_list item=branch}
         <option{if !$current_hashbase}{if $branch->GetName()==$branch_name} selected="seleced"{/if}{/if} value="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;hb={$branch->GetHash()}&amp;bn={$branch->GetName()}" data-bname="{$branch->GetName()}">{$branch->GetName()}</option>
       {/foreach}
      </select>
    {/if}

   {if $current=='tree'}
     <a data-action="tree" class="nav_item clicked" href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=tree{if $param_hb}&amp;hb={$param_hb}{/if}{if $branch_name}&amp;bn={$branch_name}{/if}">{t}Tree{/t}</a>
   {else}
     <a class="nav_item" href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=tree{if $param_hb}&amp;hb={$param_hb}{/if}{if $tree}&amp;h={$tree->GetHash()}{/if}{if $branch_name}&amp;bn={$branch_name}{/if}">{t}Tree{/t}</a>
   {/if}
  
 {if $bs_noneed} 
     <a data-action="log" class="nav_item clicked" href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=log{if $logmark}&amp;m={$logmark->GetHash()}{/if}{if $branch_name}&amp;bn={$branch_name}{/if}">{t}Commits{/t}</a>
 {else}
   {if $current=='log'}
     <a data-action="log" class="nav_item clicked" href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=log{if $param_hb}&amp;hb={$param_hb}{/if}{if $logmark}&amp;m={$logmark->GetHash()}{/if}{if $branch_name}&amp;bn={$branch_name}{/if}">{t}Commits{/t}</a>
   {else}
     <a class="nav_item" href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=log{if $param_hb}&amp;hb={$param_hb}{/if}{if $logmark}&amp;m={$logmark->GetHash()}{/if}{if $branch_name}&amp;bn={$branch_name}{/if}">{t}Commits{/t}</a>
   {/if}
 {/if}

   {if $current=='heads'}
        <a data-action="heads" class="nav_item clicked" href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=heads{if $param_hb}&amp;hb={$param_hb}{/if}{if $branch_name}&amp;bn={$branch_name}{/if}">{t}Branches{/t}&nbsp;<span class="fn">{$project->GetHeads()|@count}</span></a>
    {else}
        <a class="nav_item" href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=heads{if $param_hb}&amp;hb={$param_hb}{/if}{if $branch_name}&amp;bn={$branch_name}{/if}">{t}Branches{/t}&nbsp;<span class="fn">{$project->GetHeads()|@count}</span></a>
    {/if}

      {if $current=='tags'}
        <a data-action="tags" class="nav_item fr clicked" href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=tags{if $param_hb}&amp;hb={$param_hb}{/if}{if $branch_name}&amp;bn={$branch_name}{/if}">{t}Tags{/t}&nbsp;<span class="fn">{$project->GetTags()|@count}</span></a>
      {else}
        <a class="nav_item fr" href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=tags{if $param_hb}&amp;hb={$param_hb}{/if}{if $branch_name}&amp;bn={$branch_name}{/if}">{t}Tags{/t}&nbsp;<span class="fn">{$project->GetTags()|@count}</span></a>
      {/if}


  {*if $current=='summary'}
     {t}summary{/t}
   {else}
     <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=summary">{t}summary{/t}</a>
   {/if}
   {if $current=='shortlog' || !$commit}
     {t}shortlog{/t}
   {else}
     <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=shortlog{if $logcommit}&amp;h={$logcommit->GetHash()}{/if}{if $logmark}&amp;m={$logmark->GetHash()}{/if}">{t}shortlog{/t}</a>
   {/if}
   {if $current=='commit' || !$commit}
     {t}commit{/t}
   {else}
     <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=commit&amp;h={$commit->GetHash()}">{t}commit{/t}</a>
   {/if}
   {if $current=='commitdiff' || !$commit}
     {t}commitdiff{/t}
   {else}
     <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=commitdiff&amp;h={$commit->GetHash()}">{t}commitdiff{/t}</a>
   {/if*}
      
<script type="text/javascript">
var CURRENT_HASH = "{$current_hashbase}";
{literal}
$("#branch_selector").change(function(){
  var _href = $(this).val();
  if(_href != CURRENT_HASH)
    window.location.href = $(this).val() + "&a=" + ($(".nav_item.clicked").length ? $(".nav_item.clicked").attr("data-action") : "tree");
});
</script>
{/literal}
 

