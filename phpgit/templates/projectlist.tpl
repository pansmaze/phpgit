{*
 *  projectlist.tpl
 *  gitphp: A PHP git repository browser
 *  Component: Project list template
 *
 *  Copyright (C) 2009 Christopher Han <xiphux@gmail.com>
 *}
{include file='header.tpl'}
<div class="project_list">
  <div class="guide radius_box">
    <label class="warehouse_num">{t}共有{/t}{$project_num}{t}个仓库{/t}</label><a href="{$SCRIPT_NAME}?a=pconf" target="_blank" style="position:absolute;top:10px;left:100px;">仓库管理</a>
    <form method="get" action="index.php" id="projectSearchForm" enctype="application/x-www-form-urlencoded">
       <label class="search_hint" for="search_input">{t}Search projects{/t}...</label><input id="search_input" type="text" name="s" class="projectSearchBox" {if $search}value="{$search}"{/if} /> <a href="index.php" class="clearSearch" {if !$search}style="display: none;"{/if}>X</a> {if $javascript}<img src="images/search-loader.gif" class="searchSpinner" style="display: none;" />{/if}
    </form>
    <ul class="guide_bar">
      <label id="active_offset"></label>
      <li id="all_category"{if '' == $active_cate} class="active"{/if} data-cate="">{t}所有仓库{/t}</li>
      {foreach name=category from=$category item=c}
      {if !empty($c)}
      <li data-cate="{$c}">{t}{$c}{/t}</li>
      {/if}
      {/foreach}
    </ul>
  </div>
  {literal}
  <script type="text/javascript">
    $("#search_input").focus(function() {
      $("#projectSearchForm > .search_hint").hide();
    });
    $("#search_input").blur(function() {
      if (""==$(this).val()) {
        $("#projectSearchForm > .search_hint").show();
      }
    });
    function showCate(cat){
	cat = $(cat);
	cat.siblings(".active").removeClass("active");
	cat.addClass("active");
	$("#active_offset").animate({
	"left": (cat.position().left-1)+"px",
	"width": (cat.width()+2)+"px"
	},300);
	var category = cat.attr("data-cate");
	if ("" == category) {
	    $(".project").fadeIn(300);
	}else{
	    $(".project").hide();
	    $(".project[data-cate="+category+"]").fadeIn(300);
	}
    }
    $(".guide_bar > li").click(function () {
      if ($(this).hasClass("active")) {
        return false;
      }
      showCate(this);
      window.location.hash = encodeURIComponent($(this).attr('data-cate'));
    });
    $(function(){
	var hash = window.location.hash;
        $('.guide_bar > li').each(function(i, li){
	   if(hash == '#' +  encodeURIComponent($(li).attr('data-cate')) || hash == '#' + $(this).attr('data-cate')){
	        showCate(li);
	   }
        });
    });
  </script>
  {/literal}
  {foreach name=projects from=$projectlist item=proj}
  <div class="project radius_box" data-cate="{$proj->GetCategory()}">
    <h2>
      <a class="pname" href="{$SCRIPT_NAME}?p={$proj->GetProject()|urlencode}" title="{$proj->GetProject()}">{$proj->GetProject()}</a>
    </h2>
    <h3>
      <span class="owner">{t}Owner{/t}: {$proj->GetOwner()|escape:'html'}</span>
      <span class="last_change">{t}Last Change{/t}: 
        {assign var=projecthead value=$proj->GetHeadCommit()}
        {if $projecthead}
          {if $proj->GetAge() < 7200}   {* 60*60*2, or 2 hours *}
            <span class="agehighlight"><strong><em>{$proj->GetAge()|agestring}</em></strong></span>
          {elseif $proj->GetAge() < 172800}   {* 60*60*24*2, or 2 days *}
            <span class="agehighlight"><em>{$proj->GetAge()|agestring}</em></span>
          {else}
            <em>{$proj->GetAge()|agestring}</em>
          {/if}
        {else}
          <em class="empty">{t}No commits{/t}</em>
        {/if}
      </span>
    </h3>
    <div class="description">{$proj->GetDescription()|escape:'html'}</div>
    <div class="project-url shade">
      <p>
        <label class="readonly_url clicked" data-url="{$proj->GetCloneUrl()}">只读地址</label>
        <label class="writeable_url" data-url="{$proj->GetPushUrl()}">可写地址</label>
        <input type="text" class="url_displayer" readonly="readonly" value="{$proj->GetCloneUrl()}"/>
      </p>
      {if null !== $proj->GetWebsite()}<a class="demo_url" target="_blank" href="{$proj->GetWebsite()}">{$proj->GetWebsite()}</a>{/if}
    </div>
  </div>
  {foreachelse}
    {if $search}
    <div class="message">{t 1=$search}No matches found for "%1"{/t}</div>
    {else}
    <div class="message">{t}No projects found{/t}</div>
    {/if}
  {/foreach}
</div>
<div class="related_info">
  {php}
    include '/home/ada/www/ued.etao.net/tms/rgn/webgit/git_support.html';
    include '/home/ada/www/ued.etao.net/tms/rgn/webgit/git_doc.html';
  {/php}
</div>
{literal}
<script type="text/javascript">
  $(".readonly_url,.writeable_url").click(function() {
    $(this).siblings(".clicked").removeClass("clicked");
    $(this).addClass("clicked");
    $(this).siblings(".url_displayer").val($(this).attr("data-url")).select();
  });
  $(".url_displayer").click(function(){$(this).select()});
</script>
{/literal}
{include file='footer.tpl'}

