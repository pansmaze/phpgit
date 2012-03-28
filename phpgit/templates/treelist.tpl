{*
 * Tree list
 *
 * Tree filelist template fragment
 *
 * @author Christopher Han <xiphux@gmail.com>
 * @copyright Copyright (c) 2010 Christopher Han
 * @package GitPHP
 * @subpackage Template
 *}

<thead>
  <tr>
    <th>{t}Name{/t}</th>
    <th>{t}Update{/t}</th>
    <th>
      <div class="history">
        {if $view_data=='root'}
	<a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=log&amp;hb={$commit->GetHash()}{if $branch_name}&amp;bn={$branch_name}{/if}">{t}history{/t}</a>
        {else}
	<a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=log&amp;hb={$commit->GetHash()}&amp;f={$tree->GetPath()}&amp;ftype=tree{if $branch_name}&amp;bn={$branch_name}{/if}">{t}history{/t}</a>
        {/if}
     </div>{t}Message{/t}
    </th>
  </tr>
</thead>
<tbody>
{if $view_data!='root'}
<tr>
  <td>
    {if ''!=$parent_path}
    <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=tree&amp;hb={$commit->GetHash()}&amp;{$parent_path}" class="parent_path_link">..</a>
    {else}
    <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=tree" class="parent_path_link">..</a>
    {/if}
  </td>
</tr>
{/if}
{foreach from=$tree->GetContents(true) item=treeitem}
  {assign var=this_commit value=$treeitem->GetCommit()}
  <tr class="{cycle values="light,dark"}">
    <td class="name">
       <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a={$treeitem->GetType()}&amp;h={$treeitem->GetHash()}&amp;hb={$commit->GetHash()}&amp;f={$treeitem->GetPath(true)}&amp;bn={$branch_name}" class="{$treeitem->GetType()}_link">{$treeitem->GetName(true)}</a>
    </td>
    <td class="update" title="{if $this_commit->GetAge() > 60*60*24*7*2}{$this_commit->GetAge()|agestring}{else}{$this_commit->GetCommitterEpoch()|date_format:"%Y-%m-%d"}{/if}">
	<em>{if $this_commit->GetAge() > 60*60*24*7*2}{$this_commit->GetCommitterEpoch()|date_format:"%Y-%m-%d"}{else}{$this_commit->GetAge()|agestring}{/if}</em>
    </td>
    <td class="message">
     {*<a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=snapshot&amp;h={$treeitem->GetHash()}&amp;f={$treeitem->GetPath(true)}&amp;bn={$branch_name}" class="snapshotTip">{t}snapshot{/t}</a>*}
      <span class="author_name">[{$this_commit->GetAuthorName()}]</span>
      <a class="history_link" href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=log&amp;hb={$commit->GetHash()}&amp;f={$treeitem->GetPath(true)}&amp;ftype={$treeitem->GetType()}&amp;bn={$branch_name}">{$this_commit->GetTitle(120)|escape:'html'}</a>
    </td>
  </tr>
{/foreach}
</tbody>
{*foreach from=$tree->GetContents() item=treeitem}
  <tr class="{cycle values="light,dark"}">
    <td class="monospace perms">{$treeitem->GetModeString()}</td>
    {if $treeitem instanceof GitPHP_Blob}
      <td class="filesize">{$treeitem->GetSize()}</td>
      <td></td>
      <td class="list fileName">
        <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=blob&amp;h={$treeitem->GetHash()}&amp;hb={$commit->GetHash()}&amp;f={$treeitem->GetPath()}" class="list">{$treeitem->GetName()}</a>
      </td>
      <td class="link">
        <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=blob&amp;h={$treeitem->GetHash()}&amp;hb={$commit->GetHash()}&amp;f={$treeitem->GetPath()}">{t}blob{/t}</a>
	 | 
	<a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=history&amp;h={$commit->GetHash()}&amp;f={$treeitem->GetPath()}">{t}history{/t}</a>
	 | 
	<a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=blob_plain&amp;h={$treeitem->GetHash()}&amp;f={$treeitem->GetPath()}">{t}plain{/t}</a>
      </td>
    {elseif $treeitem instanceof GitPHP_Tree}
      <td class="filesize"></td>
      <td class="expander"></td>
      <td class="list fileName">
        <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=tree&amp;h={$treeitem->GetHash()}&amp;hb={$commit->GetHash()}&amp;f={$treeitem->GetPath()}" class="treeLink">{$treeitem->GetName()}</a>
      </td>
      <td class="link">
        <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=tree&amp;h={$treeitem->GetHash()}&amp;hb={$commit->GetHash()}&amp;f={$treeitem->GetPath()}">{t}tree{/t}</a>
	 | 
	<a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=snapshot&amp;h={$treeitem->GetHash()}&amp;f={$treeitem->GetPath()}" class="snapshotTip">{t}snapshot{/t}</a>
      </td>
    {/if}
  </tr>
{/foreach*}
