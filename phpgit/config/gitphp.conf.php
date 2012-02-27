<?php
/**
 * GitPHP Config file
 *
 * Copy this example file to config/gitphp.conf.php
 *
 * @author Christopher Han <xiphux@gmail.com>
 * @copyright Copyright (c) 2010 Christopher Han
 * @package GitPHP
 * @subpackage Config
 */

/*
 * projectroot
 * Full directory on server where projects are located
 */
$gitphp_conf['projectroot'] = 'D:\\projects\\web_git_server\\phpgit\\';



/*
 * cache
 * Turns on template caching. If in doubt, leave it off
 * You will need to create a directory 'cache' and make it
 * writable by the server
 */
//$gitphp_conf['cache'] = true;

/*
 * objectcache
 * Turns on object caching.  This caches immutable pieces of
 * data from the git repository.  You will need to create a
 * directory 'cache' and make it writable by the server.
 * This can be used in place of the template cache, or
 * in addition to it for the maximum benefit.
 */
//$gitphp_conf['objectcache'] = true;


$gitphp_conf['debug'] = false;
$gitphp_conf['gitbin'] = 'C:\\Progra~1\\Git\\bin\\git.exe';
$gitphp_conf['geshi'] = true;
$gitphp_conf['locale'] = 'en_US';
$gitphp_conf['encoding'] = 'GBK';
