<?php
/**
 * GitPHP Controller Log
 *
 * Controller for displaying a log
 *
 * @author Christopher Han
 * @copyright Copyright (c) 2010 Christopher Han
 * @package GitPHP
 * @subpackage Controller
 */

/**
 * Log controller class
 *
 * @package GitPHP
 * @subpackage Controller
 */
class GitPHP_Controller_Log extends GitPHP_ControllerBase
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
		if (isset($_GET['pg'])){
			return 'log_block.tpl';
		}else{
			$this->tpl->assign('extracss_file','page/log');
			if (isset($this->params['short']) && ($this->params['short'] === true)) {
				return 'shortlog.tpl';
			}
			return 'log.tpl';
		}
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
		return $this->params['hash'] . '|' . $this->params['page'] . '|' . (isset($this->params['mark']) ? $this->params['mark'] : '');
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
		if (isset($this->params['short']) && ($this->params['short'] === true)) {
			if ($local) {
				return __('shortlog');
			}
			return 'shortlog';
		}
		if ($local) {
			return __('Commits');
		}
		return 'Commits';
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
		if (isset($_GET['hb']))
		{
			$this->params['hash'] = $_GET['hb'];
		} else if (isset($_GET['bn'])){
			$this->params['hash'] = $_GET['bn'];
		} else {	
			$this->params['hash'] = 'HEAD';
		}
		if (isset($_GET['pg']))
			$this->params['page'] = $_GET['pg'];
		else
			$this->params['page'] = 0;
		if (isset($_GET['m']))
			$this->params['mark'] = $_GET['m'];
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
		$co = $this->project->GetCommit($this->params['hash']);
		$this->tpl->assign('commit', $co);
//		$this->tpl->assign('revhash', $this->params['hash']);
		$this->tpl->assign('head', $this->project->GetHeadCommit());
		$this->tpl->assign('page',$this->params['page']);
		if (isset($_GET['f']))
		{
			$revlist = $this->project->GetLog($this->params['hash'], 101, ($this->params['page'] * 100), array($_GET['f'], $_GET['ftype']));
			$this->tpl->assign('pathobj', array_pop($revlist));
		} else {
			$revlist = $this->project->GetLog($this->params['hash'], 101, ($this->params['page'] * 100));
		}
		if ($revlist) {
			if (count($revlist) > 100) {
				$this->tpl->assign('hasmorerevs', true);
				$revlist = array_slice($revlist, 0, 100);
			}
			$this->tpl->assign('revlist', $revlist);
		}

		if (isset($this->params['mark'])) {
			$this->tpl->assign('mark', $this->project->GetCommit($this->params['mark']));
		}
	}

}
