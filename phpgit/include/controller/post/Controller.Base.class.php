<?php
/**
 * GitPHP post Controller base
 *
 * Controller base
 *
 * @author Shiyan.zyj <shiyan.zyj@taobao.com>
 * @copyright Copyright (c) 2012 Shiyan.zyj
 * @package GitPHP
 * @subpackage Controller/post
 */

/**
 * Controller Base
 *
 * @package GitPHP
 * @subpackage Controller
 */
require_once(GITPHP_POSTCTRLDIR . 'Controller.Base.class.php');

abstract class Base
{
	public function __construct()
	{
		//FIXME
	}

	public abstract function index();
}
