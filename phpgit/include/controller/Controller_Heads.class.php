<?php
/**
 * GitPHP Controller Heads
 *
 * Controller for displaying heads
 *
 * @author Christopher Han <xiphux@gmail.com>
 * @copyright Copyright (c) 2010 Christopher Han
 * @package GitPHP
 * @subpackage Controller
 */

/**
 * Heads controller class
 *
 * @package GitPHP
 * @subpackage Controller
 */
class GitPHP_Controller_Heads extends GitPHP_ControllerBase
{

	/**
	 * __construct
	 *
	 * Constructor
	 *
	 * @access public
	 * @return controller
	 */
	public function __construct()
	{
		parent::__construct();
		if (!$this->project) {
			throw new GitPHP_MessageException(__('Project is required'), true);
		}
	}

	/**
	 * GetTemplate
	 *
	 * Gets the template for this controller
	 *
	 * @access protected
	 * @return string template filename
	 */
	protected function GetTemplate()
	{
		return 'heads.tpl';
	}

	/**
	 * GetCacheKey
	 *
	 * Gets the cache key for this controller
	 *
	 * @access protected
	 * @return string cache key
	 */
	protected function GetCacheKey()
	{
		return '';
	}

	/**
	 * GetName
	 *
	 * Gets the name of this controller's action
	 *
	 * @access public
	 * @param boolean $local true if caller wants the localized action name
	 * @return string action name
	 */
	public function GetName($local = false)
	{
		if ($local) {
			return __('heads');
		}
		return 'heads';
	}

	/**
	 * ReadQuery
	 *
	 * Read query into parameters
	 *
	 * @access protected
	 */
	protected function ReadQuery()
	{
	}

	/**
	 * LoadData
	 *
	 * Loads data for this template
	 *
	 * @access protected
	 */
	protected function LoadData()
	{
		$head = $this->project->GetHeadCommit();
		$this->tpl->assign("head",$head);

		$headlistdata = $this->project->GetHeads();
		/* bn || master is the first branch */
		$headlist = array();
		$need_confirm = isset($_GET['bn']) && 'master' != $_GET['bn'];
		$idx = 0;
		$i = 0;
		foreach($headlistdata as $head)
		{
			if ($need_confirm && $head->GetName() == $_GET['bn'])
			{
				$idx = $i;
			}
			if ('master' == $head->GetName())
			{
				array_unshift($headlist, $head);
			} else {
				$headlist[] = $head;
			}
			$i++;
		}
		if ($need_confirm)
		{
			$temp = $headlist[$idx];
			array_unshift($headlist, $temp);
			unset($headlist[$idx+1]);
		}
		
		if (isset($headlist) && (count($headlist) > 0)) {
			$this->tpl->assign("headlist",$headlist);
		}
	}

}
