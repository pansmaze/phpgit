<?php
/**
 * GitPHP Project config file
 *
 * Copy this example file to config/projects.conf.php
 *
 * @author Christopher Han <xiphux@gmail.com>
 * @copyright Copyright (c) 2010 Christopher Han
 * @package GitPHP
 * @subpackage Config
 */


/*
 * git_projects
 * List of projects
 *
 * There are three ways to list projects:
 *
 * 1. Array of projects
 */
$git_projects = array(
	'.git',
	'a.git',
	'b.git',
	'c.git',
	'd.git'
);


/*
 * 2. Path to file with list of projects
 * Points to a flat file with a list of projects,
 * one on each line. Can also read Gitosis project lists.
 */
//$git_projects = '/git/projectlist.txt';

/*
 * 3. Leave commented to read all projects in the project root
 */


/*
 * git_projects_settings
 *
 * This is used to specify override settings for individual projects.
 * This is an array, where each key is the project, and the value is an
 * array of settings.  This can be used with any of the project list
 * methods above.
 *
 * The settings array can have the following key/value settings:
 *
 * 'category': the category for the project.
 *
 * 'owner': the owner of the project.  This overrides the actual owner
 *
 * 'description': the description of the project.  This overrides the 
 *		  description in the project's description file
 *
 * 'cloneurl': the full clone url of the project.  This overrides the
 *	       clone URL setting in the config for this project.
 *	       This can also be an empty string to override the global
 *             clone url to say that only this project has no clone url.
 *
 * 'pushurl': the full push url of the project.  This overrides the
 *	      push URL setting in the config for this project.
 *	      This can also be an empty string to override the global
 *	      push url to say that only this project has no push url.
 *
 * 'bugpattern': the bug number pattern of the project.  This overrides
 *		 the bug pattern setting in the config for this project.
 *		 This can also be an empty string to override the global
 *		 bug pattern to say that only this project has no bug
 *		 pattern.
 *
 * 'bugurl': the bug url for this project.  This overrides the bug url
 *	     setting in the config for this project.  This can also be
 *	     an empty string to override the global bug url to say that
 *	     only this project has no bug url.
 */
//$git_projects_settings['php/gitphp.git'] = array(
//	'category' => 'PHP',
//	'description' => 'GitPHP, a web-based git repository browser in PHP',
//	'owner' => 'Christopher Han',
//	'cloneurl' => 'http://git.xiphux.com/php/gitphp.git',
//	'pushurl' => '',
//	'bugpattern' => '/#([0-9]+)/',
//	'bugurl' => 'http://mantis.xiphux.com/view.php?id=${1}'
//);

$git_projects_settings['.git'] = array(
	#'description' => 'search auto script tools',
	'category' => 'tools',
	'owner' => 'Etao UED F2E Team',
	'cloneurl' => 'http://ued.etao.net/git/phpgit.git',
	'pushurl' => 'git@ued.etao.net:phpgit.git',
	'website' => 'http://www.etao.com',
	'charset' => 'utf-8'
);
$git_projects_settings['a.git'] = array(
  'description' => 'search auto script tools',
  'category' => 'tools',
  'owner' => 'Etao UED F2E Team',
  'cloneurl' => 'http://ued.etao.net/git/phpgit.git',
  'pushurl' => 'git@ued.etao.net:phpgit.git',
  'website' => 'http://www.etao.com'
);
$git_projects_settings['b.git'] = array(
  'description' => 'search auto script tools',
  'category' => 'test',
  'owner' => 'Etao UED F2E Team',
  'cloneurl' => 'http://ued.etao.net/git/phpgit.git',
  'pushurl' => 'git@ued.etao.net:phpgit.git',
  'website' => 'http://www.etao.com'
);
$git_projects_settings['c.git'] = array(
  'description' => 'search auto script tools',
  'category' => 'help',
  'owner' => 'Etao UED F2E Team',
  'cloneurl' => 'http://ued.etao.net/git/phpgit.git',
  'pushurl' => 'git@ued.etao.net:phpgit.git',
  'website' => 'http://www.etao.com'
);
$git_projects_settings['d.git'] = array(
  'description' => 'search auto script tools',
  'category' => 'test',
  'owner' => 'Etao UED F2E Team',
  'cloneurl' => 'http://ued.etao.net/git/phpgit.git',
  'pushurl' => 'git@ued.etao.net:phpgit.git',
);
//$git_projects_settings['core/fbx.git'] = array(
//	'description' => 'FBX music player',
//	'category' => 'Core'
//);
//$git_projects_settings['php/mdb.git'] = array(
//	'category' => 'PHP',
//	'description' => 'MDB: Media Database',
//	'cloneurl' => '',
//	'pushurl' => ''
//);
