<?php
/**
 * GitPHP BaseExport
 *
 * Base Class for git model export
 *
 * @author Shiyan.zyj <shiyan.zyj@taobao.com>
 * @copyright Copyright (c) 2012 Shiyan.zyj
 * @package GitPHP
 * @subpackage Model
 */

/**
 * Base Export class
 *
 * @package GitPHP
 * @subpackage Git
 */
require_once(GITPHP_MODELDIR . 'ProjectsExport.class.php');
class BaseExport
{
	/**
	 * db
	 *
	 * Stores the db Link_ID handle
	 *
	 * @access private
	 */
	protected $db;

	/**
	 * tabel
	 *
	 * Stores the tabel name
	 *
	 * @access private
	 */
	protected $tabel;

	/**
	 * __construct
	 *
	 * Constructor
	 *
	 */
	public function __construct($db, $tabel)
	{
		$this->db = DB_MYSQL::get_db($db);
		$this->tabel = $tabel;
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
		$tabel = $this->tabel;
		
		return $this->db->insert($tabel, $array_data);
	}

	/**
	 * update_one
	 *
	 * Update a single record
	 *
	 * @return data array()
	 */
	protected function update_one($where, $array_data)
	{
		//where is necessary
		return $this->db->update($this->tabel, $array_data, $where);
	}

	/**
	 * real_delete
	 *
	 * realy delete a single record
	 *
	 * @return $ret bool
	 */
	protected function real_delete($where)
	{
		return $this->db->delete($this->tabel, $where);
	}

	/**
	 * delete
	 *
	 * delete a single record (set status = -1)
	 *
	 * @return $ret bool
	 */
	protected function delete($where)
	{
		return $this->db->update($this->tabel,"status='-1'", $where);
	}

	/**
	 * fetch_one
	 *
	 * Fetch all feild of a single data
	 *
	 * @return data array()
	 */
	public function fetch_one($where = '')
	{
		$tabel = $this->tabel;
		$where = '' !== $where ? ' WHERE ' . $where : '';
		$sql = "SELECT * FROM $tabel$where";

		return $this->db->get_one($sql);
	}

	/**
	 * fetch_all
	 *
	 * Fetch all data
	 *
	 * @return data array()
	 */
	public function fetch_all($where = '', $orderby = '')
	{
		$tabel = $this->tabel;
		$where = '' !== $where ? ' WHERE ' . $where : '';
		$orderby = '' !== $orderby ? ' order by ' . $orderby : '';
		$sql = "SELECT * FROM $tabel$where$orderby";
		return $this->db->get_all($sql);
	}


	/**
	 * get_by_id
	 *
	 * Get a single record by feild 'id'
	 *
	 * @return ret bool|array()
	 */
	public function get_by_id($id)
	{
		$where = "id = '$id'";
		
		return $this->fetch_one($where);
	}

}
