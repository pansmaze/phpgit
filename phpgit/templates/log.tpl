{*
 *  log.tpl
 *  gitphp: A PHP git repository browser
 *  Component: Log view template
 *
 *  Copyright (C) 2009 Christopher Han <xiphux@gmail.com>
 *}
{include file='header.tpl'}

 {* Nav *}
 <div class="page_nav">
   {include file='nav.tpl' current='log' logcommit=$commit treecommit=$commit logmark=$mark}
{*   <div class="sub_nav">
      {if ($commit && $head) && (($commit->GetHash() != $head->GetHash()) || ($page > 0))}
        <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=log{if $mark}&amp;m={$mark->GetHash()}{/if}">{t}HEAD{/t}</a>
      {else}
        <span>{t}HEAD{/t}</span>
      {/if}
      &sdot; 
      {if $page > 0}
        <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=log&amp;h={$commit->GetHash()}&amp;pg={$page-1}{if $mark}&amp;m={$mark->GetHash()}{/if}{if $branch_name}&amp;bn={$branch_name}{/if}" accesskey="p" title="Alt-p">{t}prev{/t}</a>
      {else}
        <span>{t}prev{/t}</span>
      {/if}
      &sdot; 
      {if $hasmorerevs}
        <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=log&amp;h={$commit->GetHash()}&amp;pg={$page+1}{if $mark}&amp;m={$mark->GetHash()}{/if}{if $branch_name}&amp;bn={$branch_name}{/if}" accesskey="n" title="Alt-n">{t}next{/t}</a>
      {else}
        <span>{t}next{/t}</span>
      {/if}
      <br />
      {if $mark}
        {t}selected{/t} &sdot;
        <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=commit&amp;h={$mark->GetHash()}{if $branch_name}&amp;bn={$branch_name}{/if}" class="list commitTip" {if strlen($mark->GetTitle()) > 30}title="{$mark->GetTitle()|escape:'html'}"{/if}><strong>{$mark->GetTitle(30)|escape:'html'}</strong></a>
        &sdot;
        <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=log&amp;h={$commit->GetHash()}&amp;pg={$page}{if $branch_name}&amp;bn={$branch_name}{/if}">{t}deselect{/t}</a>
        <br />
      {/if}
   </div>*}
 </div>
{if $revlist}
<div class="diff_commit_container">
	<input data-hrefbase="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=commitdiff&amp;" type="button" value="Diff selected Commits" id="diff_commit_button" class="disabled" />
   {if $pathobj}{include file='path.tpl' pathobject=$pathobj target='no_link'}{/if}
</div>
{/if}
{include file='log_block.tpl'}
{if $hasmorerevs}
<div class="more_commit_container">
	<input type="button" value="Show More Commits" id="show_commit_button" />
</div>
{/if}



{*   <div class="title">
     <span class="age">{$rev->GetAge()|agestring}</span>
     <a title="view commit details" href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=commit&amp;h={$rev->GetHash()}{if $branch_name}&amp;bn={$branch_name}{/if}" class="title">{$rev->GetTitle()|escape:'html'}</a>
     {include file='refbadges.tpl' commit=$rev}
   </div>
   <div class="log_body">
     {assign var=bugpattern value=$project->GetBugPattern()}
     {assign var=bugurl value=$project->GetBugUrl()}
     {foreach from=$rev->GetComment() item=line}
       {$line|htmlspecialchars|buglink:$bugpattern:$bugurl}<br />
     {/foreach}
     {if count($rev->GetComment()) > 0}
       <br />
     {/if}
   </div>

   <div class="title_text">
     <div class="log_link">
       {assign var=revtree value=$rev->GetTree()}
       *<a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=commit&amp;h={$rev->GetHash()}">{t}commit{/t}</a> | *
	<a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=tree&amp;h={$revtree->GetHash()}&amp;hb={$rev->GetHash()}">{t}tree{/t}</a> |
	<a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=commitdiff&amp;h={$rev->GetHash()}">{t}commitdiff{/t}</a> | 
       {if $mark}
         {if $mark->GetHash() == $rev->GetHash()}
	   <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=log&amp;h={$commit->GetHash()}&amp;pg={$page}{if $branch_name}&amp;bn={$branch_name}{/if}">{t}deselect{/t}</a>
	 {else}
	   {if $mark->GetCommitterEpoch() > $rev->GetCommitterEpoch()}
	     {assign var=markbase value=$mark}
	     {assign var=markparent value=$rev}
	   {else}
	     {assign var=markbase value=$rev}
	     {assign var=markparent value=$mark}
	   {/if}
	   <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=commitdiff&amp;h={$markbase->GetHash()}&amp;hp={$markparent->GetHash()}{if $branch_name}&amp;bn={$branch_name}{/if}">{t}diff with selected{/t}</a>
	 {/if}
       {else}
         <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=log&amp;h={$commit->GetHash()}&amp;pg={$page}&amp;m={$rev->GetHash()}">{t}select for diff{/t}</a>
       {/if}
     </div>
    by: <em>{$rev->GetAuthorName()} [{$rev->GetAuthorEpoch()|date_format:"%a, %d %b %Y %H:%M:%S %z"}]</em>
   </div>
    {foreachelse}
   <div class="title">
     <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=tree" class="title">&nbsp</a>
   </div>
   <div class="page_body">
     {if $commit}
       {assign var=commitage value=$commit->GetAge()|agestring}
       {t 1=$commitage}Last change %1{/t}
     {else}
     <em>{t}No commits{/t}</em>
     {/if}
     <br /><br />
   </div>*}



 {include file='footer.tpl'}
{literal}
<script type="text/javascript">
$(document).ready(function(){
      $("input[type=checkbox]").attr("checked", false);
//  $(".commit_record").live("mouseenter", function(){
//    if($(this).find(".disabled.select_to_compare").length){
//      $(this).find(".disabled.select_to_compare").addClass("force_hlight");
//    }
//  });
//  $(".commit_record").live("mouseleave", function(){
//      $(this).find(".disabled.select_to_compare").removeClass("force_hlight");
//  });
  $("input[type=checkbox]").live("click",function(){
	$(this).next().click();
	return false;
  });
  $("#show_commit_button").data("pg", 1);
  $(".commit_box").each(function(){
    $(this).children(".commit_record:last").css({"border-bottom-left-radius":"5px","border-bottom-right-radius":"5px"});
  });
  $(".show_comment").live('click', function(){
    $(this).toggleClass("expanded");
    $(this).next().toggle();
  });
  $(".select_to_compare").live('click', function(){
    var select_set = $(".select_to_compare.selected");
    if(select_set.length == 2 && !$(this).hasClass("selected")){
      return false;
    }
    $(this).toggleClass("selected");
    if($(this).hasClass("selected")){
      $(this).prev().attr("checked", true);
    }else{
      $(this).prev().attr("checked", false);
    }
    if($(".select_to_compare.selected").length == 2){
      $("#diff_commit_button").removeClass("disabled");
      if($(".select_to_compare.selected[data-order=last]").length){
        $(".select_to_compare.selected[data-order=last]").removeAttr("data-order");
      }
      $(this).attr("data-order","last");
      $(".select_to_compare").addClass("disabled");
      $(".select_to_compare.selected").removeClass("disabled");
      $(".select_to_compare.disabled").prev().attr("disabled", "disabled");
    }else{
      $("#diff_commit_button").addClass("disabled");
      $(".select_to_compare.disabled").prev().removeAttr("disabled");
      $(".select_to_compare.disabled").removeClass("disabled");
    }
  });
  $("#diff_commit_button").click(function(){
    if(!$(this).hasClass("disabled")){
      window.location.href = $(this).attr("data-hrefbase") + "h=" + $(".select_to_compare.selected:first").attr("data-hash") + "&hp=" + $(".select_to_compare.selected:last").attr("data-hash");
      //window.location.href = $(this).attr("data-hrefbase") + "h=" + $(".select_to_compare.selected[data-order!=last]").attr("data-hash") + "&hp=" + $(".select_to_compare.selected[data-order=last]").attr("data-hash");
    }
  });
  $("#show_commit_button").click(getCommitsNextPage);
  function getCommitsNextPage(){
    $("#show_commit_button").val("Loading...").addClass("disabled");
    var this_btn = $("#show_commit_button");
    this_btn.unbind("click");
    var page_num = this_btn.data("pg");
    $.ajax({
      url: location.href + "&pg=" + page_num,
      type: "GET",
      success: function(data){
        $("#show_commit_button").parent().before(data);
        if($(".select_to_compare.selected").length == 2){
          $(".select_to_compare").addClass("disabled");
          $(".select_to_compare.selected").removeClass("disabled");
          $(".select_to_compare.disabled").prev().attr("disabled", "disabled");
        }
        if(HASMOREREVS){//has more page
          $("#show_commit_button").val("Show More Commits").removeClass("disabled");
          $("#show_commit_button").click(getCommitsNextPage);
          $("#show_commit_button").data("pg", parseInt(page_num, 10) + 1);
        }else{
          $("#show_commit_button").remove();
        }
      },
      error: function(data){
        $("#show_commit_button").parent().before('<div>Failing to get more commits...</div>');
      }
    });
  }
});
</script>
{/literal}
