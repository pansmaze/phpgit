{*
 * Pconf_add
 *
 * Add a new Project config template
 *
 * @author Shiyan.zyj <shiyan.zyj@taobao.com>
 * @copyright Copyright (c) 2012 Shiyan.zyj
 * @package GitPHP
 * @subpackage Template
 *}

{include file='header.tpl'}
<div class="input_form">
	<form action="{$SCRIPT_NAME}?a=project/add" method="post">
		<p><label>仓库名字</label>:<input name="name" type="text" /></p>
		<p><label>类别</label>:<input name="category" type="text" /></p>
		<p><label>所有者</label>:<input name="owner" type="text" /></p>
		<p><label>描述</label>:<input name="description" type="text" /></p>
		<p><label>demo地址</label>:<input name="website" type="text" /></p>
		<p><label>只读地址</label>:<input name="cloneurl" type="text" /></p>
		<p><label>可写地址</label>:<input name="pushurl" type="text" /></p>
		<p><label>项目编码</label>:<select name="charset"><option value="utf-8">utf-8</option><option value="GBK" selected="selected">GBK</option></select></p>
		<input type="submit" value="submit" />
	</form>
</div>
{include file='footer.tpl'}
