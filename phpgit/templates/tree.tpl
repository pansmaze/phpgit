{*
 *  tree.tpl
 *  gitphp: A PHP git repository browser
 *  Component: Tree view template
 *
 *  Copyright (C) 2009 Christopher Han <xiphux@gmail.com>
 *}
{include file='header.tpl'}

 {* Nav *}
   <div class="page_nav">
           {include file='nav.tpl' current='tree' logcommit=$commit}
 
       </div>
{if $tree}
	{include file='title.tpl' titlecommit=$commit}
	{include file='path.tpl' pathobject=$tree target='tree'}
 <div class="page_body">
   {* List files *}
    <div class="browser_wrapper">
	<table cellspacing="0" class="treeTable">
    	 {include file='treelist.tpl'}
	</table>
    </div>
 </div>

{else}
No file for this project
<br />
<br />
{/if}
 {include file='footer.tpl'}

