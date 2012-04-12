<?php
/**
 * GitPHP ProjectsExport
 *
 * Class for git projects model export
 *
 * @author Shiyan.zyj <shiyan.zyj@taobao.com>
 * @copyright Copyright (c) 2012 Shiyan.zyj
 * @package GitPHP
 * @subpackage Model
 */

/**
 * Git project export class
 *
 * @package GitPHP
 * @subpackage Git
 */
require_once(GITPHP_MODELDIR . 'BaseExport.class.php');
class ProjectsExport extends BaseExport
{
	/**
	 * __construct
	 *
	 * Constructor
	 *
	 */
	public function __construct()
	{
		parent::__construct('etaoux', 'project');
	}

	/**
	 * fetch_projects_name_array
	 *
	 * Fetch all the projects name array in database
	 *
	 * @return projects array()
	 */
	public function fetch_projects_name_array()
	{
		$projects_list = array();
		$p_ary = $this->fetch_all();
		foreach ($p_ary as $v)
		{
			$projects_list[] = $v['name'];
		}
		return $projects_list;
	}

	/**
	 * fetch_projects_settings
	 *
	 * Fetch all the projects settings in database
	 *
	 * @return projects array()
	 */
	public function fetch_projects_settings()
	{
		$projects_list_settings = array();
		$p_ary = $this->fetch_all();
		foreach ($p_ary as $v)
		{
			$projects_list_settings[$v['name']] = $v;
		}
		return $projects_list_settings;
	}

	/**
	 * edit
	 *
	 * edit detail info of a project by id
	 *
	 * @return ret bool
	 */
	public function edit($array_data, $id)
	{
		return parent::update_one("id='$id'", $array_data);
	}

	/**
	 * delete
	 *
	 * delete a project by id
	 *
	 * @return ret bool
	 */
	public function delete($id)
	{
		return parent::real_delete("id='$id'");
	}

	/**
	 * add
	 *
	 * Add a single record
	 *
	 * @return ret bool
	 */
	public function add($array_data)
	{
		if (!isset($array_data['name']))
		{
			return false;
		} else {
			$name = $array_data['name'];
			$ret = parent::fetch_one("name='$name'");
			if (!empty($ret))
			{
				return false;
			}
		}
		
		return parent::add($array_data);
	}


}
