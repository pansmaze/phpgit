<?php
/**
 * GitPHP post Controller
 *
 * Controller factory
 *
 * @author Shiyan.zyj <shiyan.zyj@taobao.com>
 * @copyright Copyright (c) 2012 Shiyan.zyj
 * @package GitPHP
 * @subpackage Controller/post
 */

/**
 * Controller
 *
 * @package GitPHP
 * @subpackage Controller
 */
require_once(GITPHP_POSTCTRLDIR . 'Controller.Base.class.php');

class Project extends Base
{
	private $p_model;
	public function __construct()
	{
		parent::__construct();
		require_once(GITPHP_MODELDIR . 'ProjectsExport.class.php');
                $this->p_model = new ProjectsExport();

	}

	public function index()
	{
		//FIXME
		echo 'index action';
	}

	public function add()
	{
		if (!isset($_POST['name']))
		{
			echo 'operating fail';
			exit;
		} else if (0 == preg_match("/\w*\.git$/", $_POST['name'])) {
			$_POST['name'] .= '.git';
		}
		if ($this->p_model->add($_POST))
		{
			echo 'add success!';
		} else {
			echo 'operating fail';
		}
	}

	public function edit()
	{
		$id = $_POST['id'];
		unset($_POST['id']);
		if ($this->p_model->edit($_POST, $id))
		{
			$ret = array('rst' => true, 'msg' => 'edit success');
		} else {
			$ret = array('rst' => false, 'msg' => 'edit failure');
		}
		echo json_encode($ret);
	}

	public function delete()
	{
		if (!isset($_POST['id']))
		{
			echo '{ret: false, msg: "id is request!"}';
			exit;
		}
		$id = $_POST['id'];
		if ($this->p_model->delete($id))
		{
			$ret = array('rst' => true, 'msg' => 'delete success');
		} else {
			$ret = array('rst' => false, 'msg' => 'delete failure, please try again');
		}
		echo json_encode($ret);
	}
}
