<?php
/**
 * GitPHP
 *
 * Index
 *
 * @author Christopher Han <xiphux@gmail.com>
 * @copyright Copyright (c) 2010 Christopher Han
 * @package GitPHP
 */
ini_set('display_errors','On');//FIXME if you want to push
/**
 * Define start time / memory for benchmarking
 */
define('GITPHP_START_TIME', microtime(true));
define('GITPHP_START_MEM', memory_get_usage());

/**
 * Define some paths
 */
define('GITPHP_BASEDIR', dirname(__FILE__) . '/');
define('GITPHP_CONFIGDIR', GITPHP_BASEDIR . 'config/');
define('GITPHP_LIBDIR', GITPHP_BASEDIR . 'lib/');
define('GITPHP_INCLUDEDIR', GITPHP_BASEDIR . 'include/');
define('GITPHP_GITOBJECTDIR', GITPHP_INCLUDEDIR . 'git/');
define('GITPHP_MODELDIR', GITPHP_INCLUDEDIR . 'model/');
define('GITPHP_CONTROLLERDIR', GITPHP_INCLUDEDIR . 'controller/');
define('GITPHP_POSTCTRLDIR', GITPHP_CONTROLLERDIR . 'post/');
define('GITPHP_APPDIR', GITPHP_INCLUDEDIR . 'app/');
define('GITPHP_CACHEDIR', GITPHP_INCLUDEDIR . 'cache/');
define('GITPHP_LOCALEDIR', GITPHP_BASEDIR . 'locale/');

define('GITPHP_CACHE', GITPHP_BASEDIR . 'cache/');

include_once(GITPHP_INCLUDEDIR . 'version.php');

require_once(GITPHP_INCLUDEDIR . 'Util.class.php');

require_once(GITPHP_INCLUDEDIR . 'Config.class.php');

require_once(GITPHP_INCLUDEDIR . 'Resource.class.php');

require_once(GITPHP_INCLUDEDIR . 'Log.class.php');

require_once(GITPHP_GITOBJECTDIR . 'ProjectList.class.php');

require_once(GITPHP_INCLUDEDIR . 'MessageException.class.php');

require_once(GITPHP_CONTROLLERDIR . 'Controller.class.php');

require_once(GITPHP_CACHEDIR . 'Cache.class.php');

// Need this include for the compression constants used in the config file
require_once(GITPHP_GITOBJECTDIR . 'Archive.class.php');

// Test these executables early
require_once(GITPHP_GITOBJECTDIR . 'GitExe.class.php');
require_once(GITPHP_GITOBJECTDIR . 'DiffExe.class.php');

//date_default_timezone_set('UTC');


/*
 * Set the locale based on the user's preference
 */
if(false){//hack
if ((!isset($_COOKIE[GITPHP_LOCALE_COOKIE])) || empty($_COOKIE[GITPHP_LOCALE_COOKIE])) {

	/*
	 * User's first time here, try by HTTP_ACCEPT_LANGUAGE
	 */
	if (isset($_SERVER['HTTP_ACCEPT_LANGUAGE'])) {
		$httpAcceptLang = explode(',', $_SERVER['HTTP_ACCEPT_LANGUAGE']);
		$preferredLocale = GitPHP_Resource::FindPreferredLocale($_SERVER['HTTP_ACCEPT_LANGUAGE']);
		if (!empty($preferredLocale)) {
			setcookie(GITPHP_LOCALE_COOKIE, $preferredLocale, time()+GITPHP_LOCALE_COOKIE_LIFETIME);
			GitPHP_Resource::Instantiate($preferredLocale);
		}
	}

	if (!GitPHP_Resource::Instantiated()) {
		/*
		 * Create a dummy cookie to prevent browser delay
		 */
		setcookie(GITPHP_LOCALE_COOKIE, 0, time()+GITPHP_LOCALE_COOKIE_LIFETIME);
	}

} else if (isset($_GET['l']) && !empty($_GET['l'])) {

	/*
	 * User picked something
	 */
	setcookie(GITPHP_LOCALE_COOKIE, $_GET['l'], time()+GITPHP_LOCALE_COOKIE_LIFETIME);
	GitPHP_Resource::Instantiate($_GET['l']);

} else if (isset($_COOKIE[GITPHP_LOCALE_COOKIE]) && !empty($_COOKIE[GITPHP_LOCALE_COOKIE])) {

	/*
	 * Returning visitor with a preference
	 */
	GitPHP_Resource::Instantiate($_COOKIE[GITPHP_LOCALE_COOKIE]);

}
}
//Forced set locale = en_US
	setcookie(GITPHP_LOCALE_COOKIE, 'en_US', time()+GITPHP_LOCALE_COOKIE_LIFETIME);
	GitPHP_Resource::Instantiate('en_US');


try {

	/*
	 * Configuration
	 */
	GitPHP_Config::GetInstance()->LoadConfig(GITPHP_CONFIGDIR . 'gitphp.conf.php');

	/*
	 * Use the default language in the config if user has no preference
	 * with en_US as the fallback
	 */
	if (!GitPHP_Resource::Instantiated()) {
		GitPHP_Resource::Instantiate(GitPHP_Config::GetInstance()->GetValue('locale', 'en_US'));
	}

	/*
	 * Debug
	 */
	if (GitPHP_Log::GetInstance()->GetEnabled()) {
		GitPHP_Log::GetInstance()->SetStartTime(GITPHP_START_TIME);
		GitPHP_Log::GetInstance()->SetStartMemory(GITPHP_START_MEM);
	}

	if (!GitPHP_Config::GetInstance()->GetValue('projectroot', null)) {
		throw new GitPHP_MessageException(__('A projectroot must be set in the config'), true, 500);
	}

	/*
	 * Check for required executables
	 */
	$exe = new GitPHP_GitExe(null);
	if (!$exe->Valid()) {
		throw new GitPHP_MessageException(sprintf(__('Could not run the git executable "%1$s".  You may need to set the "%2$s" config value.'), $exe->GetBinary(), 'gitbin'), true, 500);
	}
	if (!function_exists('xdiff_string_diff')) {
		$exe = new GitPHP_DiffExe();
		if (!$exe->Valid()) {
			throw new GitPHP_MessageException(sprintf(__('Could not run the diff executable "%1$s".  You may need to set the "%2$s" config value.'), $exe->GetBinary(), 'diffbin'), true, 500);
		}
	}
	unset($exe);

	/*
	 * Project list
	 */
	if (file_exists(GITPHP_CONFIGDIR . 'db.conf.php') && true) {// fetch project list from db //FIXME add all project to database to remove this switch
		require_once(GITPHP_CONFIGDIR . 'db.conf.php');
		require_once(GITPHP_LIBDIR . 'db/mysql.php');
		DB_MySQL::$DB_CONFIGS = $gitphp_conf['db']; 
		GitPHP_ProjectList::Instantiate(null, false, true);
	} else 	if (file_exists(GITPHP_CONFIGDIR . 'projects.conf.php')) {// fetch project list from conf file
		GitPHP_ProjectList::Instantiate(GITPHP_CONFIGDIR . 'projects.conf.php', false);
	} else {// no project
		GitPHP_ProjectList::Instantiate(GITPHP_CONFIGDIR . 'gitphp.conf.php', true);
	}
	if (strtolower($_SERVER['REQUEST_METHOD']) == 'post')
	{
		if (!isset($_GET['a']))
		{
			throw new GitPHP_MessageException(__('A controller name is needed, please pass paramter \'a\''), true, 500);
		}
		if ( 1 !== preg_match("/^([a-z_\/])*$/i",$_GET['a']))// controller name can only contain 'a-z', 'A-Z' or '_'
		{
			throw new GitPHP_MessageException(__('Invalid controller name of parameter \'a\' passed: ' . $_GET['a']), true, 500);
		}
		$act = explode('/', $_GET['a'], 2);
		if (!isset($act[1]))
		{
			$act[1] = 'index';//default action: index
		}
		$cname = ucfirst($act[0]);
		$controller_file = GITPHP_POSTCTRLDIR . 'Controller_' . $cname . '.class.php';
		if (file_exists($controller_file))
		{
			require_once($controller_file);
			$controller = new $cname();
			$controller->$act[1]();
		} else {
			throw new GitPHP_MessageException(__('Controller is not exist: ' . $cname), true, 500);
		}
	} else {
		$controller = GitPHP_Controller::GetController((isset($_GET['a']) ? $_GET['a'] : null));
		if ($controller) {
			$controller->RenderHeaders();
			$controller->Render();
		}
	}

	

} catch (Exception $e) {

	if (GitPHP_Config::GetInstance()->GetValue('debug', false)) {
		throw $e;
	}

	if (!GitPHP_Resource::Instantiated()) {
		/*
		 * In case an error was thrown before instantiating
		 * the resource manager
		 */
		GitPHP_Resource::Instantiate('en_US');
	}

	require_once(GITPHP_CONTROLLERDIR . 'Controller_Message.class.php');
	$controller = new GitPHP_Controller_Message();
	$controller->SetParam('message', $e->getMessage());
	if ($e instanceof GitPHP_MessageException) {
		$controller->SetParam('error', $e->Error);
		$controller->SetParam('statuscode', $e->StatusCode);
	} else {
		$controller->SetParam('error', true);
	}
	$controller->RenderHeaders();
	$controller->Render();

}

if (GitPHP_Log::GetInstance()->GetEnabled()) {
	$entries = GitPHP_Log::GetInstance()->GetEntries();
	foreach ($entries as $logline) {
		echo "<br />\n" . $logline;
	}
}

?>
