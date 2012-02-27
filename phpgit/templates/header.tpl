{*
 *  header.tpl
 *  gitphp: A PHP git repository browser
 *  Component: Page header template
 *
 *  Copyright (C) 2006 Christopher Han <xiphux@gmail.com>
 *}
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
  <!-- gitphp web interface {$version}, (C) 2006-2011 Christopher Han <xiphux@gmail.com> -->
  <head>
    <title>{$pagetitle}{if $project} :: {$project->GetProject()}{if $actionlocal}/{$actionlocal}{/if}{/if}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    {if $project}
      <link rel="alternate" title="{$project->GetProject()} log (Atom)" href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=atom" type="application/atom+xml" />
      <link rel="alternate" title="{$project->GetProject()} log (RSS)" href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=rss" type="application/rss+xml" />
    {/if}
    {if file_exists('css/gitphp.min.css')}
    <link rel="stylesheet" href="css/gitphp.min.css" type="text/css" />
    {else}
    <link rel="stylesheet" href="css/gitphp.css" type="text/css" />
    {/if}
    {if file_exists("css/$stylesheet.min.css")}
    <link rel="stylesheet" href="css/{$stylesheet}.min.css" type="text/css" />
    {else}
    <link rel="stylesheet" href="css/{$stylesheet}.css" type="text/css" />
    {/if}
    {if $extracss_file}
      {if file_exists("css/$extracss_file.min.css")}
      <link rel="stylesheet" href="css/{$extracss_file}.min.css" type="text/css" />
      {else}
      <link rel="stylesheet" href="css/{$extracss_file}.css" type="text/css" />
      {/if}
    {/if}
    {if $extracss}
    <style type="text/css">
    {$extracss}
    </style>
    {/if}
    {if $javascript}
    <script type="text/javascript">
      var GITPHP_RES_LOADING="{t escape='js'}Loading…{/t}";
      var GITPHP_RES_LOADING_BLAME_DATA="{t escape='js'}Loading blame data…{/t}";
      var GITPHP_RES_SNAPSHOT="{t escape='js'}snapshot{/t}";
      var GITPHP_RES_NO_MATCHES_FOUND='{t escape=no}No matches found for "%1"{/t}';
      var GITPHP_SNAPSHOT_FORMATS = {ldelim}
      {foreach from=$snapshotformats key=format item=extension name=formats}
        "{$format}": "{$extension}"{if !$smarty.foreach.formats.last},{/if}
      {/foreach}
      {rdelim}
    </script>
    <link rel="stylesheet" href="css/ext/jquery.qtip.css" type="text/css" />
    <script type="text/javascript" src="js/ext/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="js/ext/jquery.qtip.min.js"></script>
    {if file_exists('js/tooltips.min.js')}
    <script type="text/javascript" src="js/tooltips.min.js"></script>
    {else}
    <script type="text/javascript" src="js/tooltips.js"></script>
    {/if}
    {if file_exists('js/lang.min.js')}
    <script type="text/javascript" src="js/lang.min.js"></script>
    {else}
    <script type="text/javascript" src="js/lang.js"></script>
    {/if}
    {foreach from=$extrascripts item=script}
    {if file_exists("js/$script.min.js")}
    <script type="text/javascript" src="js/{$script}.min.js"></script>
    {else}
    <script type="text/javascript" src="js/{$script}.js"></script>
    {/if}
    {/foreach}
    {/if}
    {$smarty.capture.header}
  </head>
  <body>
    <div class="page_header">
	<div class="header-inner">
      {*if $supportedlocales}
      <div class="lang_select">
        <form action="{$SCRIPT_NAME}" method="get" id="frmLangSelect">
         <div>
	{foreach from=$requestvars key=var item=val}
	{if $var != "l"}
	<input type="hidden" name="{$var}" value="{$val}" />
	{/if}
	{/foreach}
	<label for="selLang">{t}language:{/t}</label>
	<select name="l" id="selLang">
	  {foreach from=$supportedlocales key=locale item=language}
	    <option {if $locale == $currentlocale}selected="selected"{/if} value="{$locale}">{if $language}{$language} ({$locale}){else}{$locale}{/if}</option>
	  {/foreach}
	</select>
	<input type="submit" value="{t}set{/t}" id="btnLangSet" />
         </div>
	</form>
      </div>
      {/if}
      <a href="index.php">{if $homelink}{$homelink}{else}{t}projects{/t}{/if}</a> - 
      {if $project}
        <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=tree">{$project->GetProject()}</a>
        {if $actionlocal}
           - {$actionlocal}
        {/if}
        {if $enablesearch}
          <form method="get" action="index.php" enctype="application/x-www-form-urlencoded">
            <div class="search">
              <input type="hidden" name="p" value="{$project->GetProject()}" />
              <input type="hidden" name="a" value="search" />
              <input type ="hidden" name="h" value="{if $commit}{$commit->GetHash()}{else}HEAD{/if}" />
              <select name="st">
                <option {if $searchtype == 'commit'}selected="selected"{/if} value="commit">{t}commit{/t}</option>
                <option {if $searchtype == 'author'}selected="selected"{/if} value="author">{t}author{/t}</option>
                <option {if $searchtype == 'committer'}selected="selected"{/if} value="committer">{t}committer{/t}</option>
                {if $filesearch}
                  <option {if $searchtype == 'file'}selected="selected"{/if} value="file">{t}file{/t}</option>
                {/if}
              </select> {t}search{/t}: <input type="text" name="s" {if $search}value="{$search}"{/if} />
            </div>
          </form>
        {/if}
      {/if*}
{*	<a href="index.php" class="nav_option">首页</a>*}
	<a href="index.php"><span class="nav_option">代码仓库</span></a>
{*	<a href="index.php" class="nav_option">WiKi沉淀</a>
	<a href="index.php" class="nav_option">Demo平台</a>*}
    </div> 
</div>
{if $project}
<div class="header-project_info">
	<div class="header-inner">
        	<a class="pname" href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=tree">{$project->GetProject()}</a>
    		<div class="description">{$project->GetDescription()|escape:'html'}</div>
      		{if null !== $project->GetWebsite()}<a class="demo_url" href="{$project->GetWebsite()}">{$project->GetWebsite()}</a>{/if}
		<p>
		        <label class="readonly_url clicked" data-url="{$project->GetCloneUrl()}">只读地址</label>
		        <label class="writeable_url" data-url="{$project->GetPushUrl()}">可写地址</label>
		        <input type="text" class="url_displayer" readonly="readonly" value="{$project->GetCloneUrl()}"/>
		</p>

	</div>
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

{/if}
{if $draw_shadow=='yes'}
<div class="header_shadow"></div>
{/if}
	<div class="wrapper">
          <div class="container">
