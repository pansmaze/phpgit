<?php
/**
 * GitPHP Controller Project conf
 *
 * Controller for projects configure page
 *
 * @author Shiyan.zyj <shiyan.zyj@taobao.com>
 * @copyright Copyright (c) 2012 Shiyan.zyj
 * @package GitPHP
 * @subpackage Controller
 */

/**
 * User controller class
 *
 * @package GitPHP
 * @subpackage Controller
 */
class GitPHP_Controller_ProjectConf extends GitPHP_ControllerBase
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
		$this->tpl->assign('extracss_file','page/project_conf');
		if (isset($_GET['action']) && $_GET['action'] == 'add')
		{
			$this->tpl->assign('extrascripts','project_conf');
			return 'pconf_add.tpl';
		} elseif (isset($_GET['action']) && $_GET['action'] == 'edit') {
			$this->tpl->assign('extrascripts','project_conf');
			return 'pconf_edit.tpl';
		} else {
			return 'pconf.tpl';
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
			return __('pconf');
		}
		return 'pconf';
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
		if (isset($_GET['id']))
		{
			$this->params['p_id'] = $_GET['id'];
		}
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
		require_once(GITPHP_MODELDIR . 'ProjectsExport.class.php');
		$p_model = new ProjectsExport();
		if (isset($this->params['p_id']))
		{
			$this->tpl->assign('p_id', $this->params['p_id']);
			$p_info = $p_model->get_by_id($this->params['p_id']);
			$p_info = $this->_convert_key($p_info, true);
			$this->tpl->assign('p_info', $p_info);
		} else {
			$projects = $p_model->fetch_all();
			foreach ($projects as $k => $p)
			{
				$projects[$k] = $this->_convert_key($p);
			}
			$this->tpl->assign('plist', $projects);
		}
	}

	/**
	 * _convert_key
	 *
	 * convert the key to display
	 *
	 * @access private
	 */
	private function _convert_key($project, $keep_key = false)
	{
		$dict = array(
			'name' => '仓库名字',
			'category' => '类别',
			'owner' => '所有者',
			'description' => '描述',
			'website' => 'demo地址',
			'cloneurl' => '只读地址',
			'pushurl' => '可写地址',
			'charset' => '项目编码',
		);
		$ret = array();
		foreach ($project as $k => $v)
		{
			if (isset($dict[$k]))
			{
				if ($keep_key)
				{
					$ret[$k . '|' . $dict[$k]] = $v;
				} else {
					$ret[$dict[$k]] = $v;
				}
			} else {
				$ret[$k] = $v;
			}
		}
		return $ret;
	}

}
