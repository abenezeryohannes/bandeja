<?php

namespace Modules\Util\UI\Form;

use Illuminate\Queue\SerializesModels;
use Illuminate\Foundation\Events\Dispatchable;

use Illuminate\Support\Facades\Storage;

class Field
{
	protected $_id;
	protected $_name;
	protected $_type;
	protected $_label;
	protected $_required;
	protected $_icon;
	protected $_column;
	protected $_default;

	protected $_input_type;
	protected $_options = [];
	protected $_multiple;

	public function __construct($id, $type)
	{
		$this->_id = $id;
		$this->_name = $id;
		$this->_type = $type;
		// ak defaults
		$this->_column = "col-md-6";
		// return $this;
	}

	public function required($t=true)
	{
		if ($t) {
			$this->_required = "required";
		}else{
			$this->_required = false;
		}
		return $this;
	}



	public function icon($t)
	{
		$this->_icon = $t;
		return $this;
	}

	public function label($t)
	{
		$this->_label = $t;
		return $this;
	}

	public function column($t)
	{
		$this->_column = $t;
		return $this;
	}

	public function default($t)
	{
		$this->_default = $t;
		return $this;
	}

	public function input_type($t)
	{
		$this->_input_type = $t;
		return $this;
	}

	public function option($t)
	{
		array_push($this->_options, $t);
		return $this;
	}

	public function options($t)
	{
		$this->_options = $t;
		return $this;
	}

	public function multiple($t=true)
	{
		$this->_multiple = $t;
		return $this;
	}







	public function generate()
	{
		$field = [ 'label' => $this->_label, 'icon' => $this->_icon, 'type' => $this->_type, 'column' => $this->_column, 'default' =>  $this->_default, 'name' => $this->_name ];
		switch ($this->_type) {
			case 'input':
			  	$field['input_type'] = $this->_input_type;
				break;

			case 'file':
			  	// $field['file_types'] = $this->_file_types;
				break;

			case 'textarea':
			  	// $field['file_types'] = $this->_file_types;
				break;

			case 'switcher':
			  	$field['options'] = $this->_options;
			  	$field['multiple'] = $this->_multiple;
				break;
			case 'select':
			  	$field['options'] = $this->_options;
			  	$field['multiple'] = $this->_multiple;
				break;
			case 'blank':
				break;
			case 'custom':
				break;
			
			default:
				throw new \Exception("unknown field type", 1);
				break;
		}
		if ($this->_required) {
			$field['required'] = 'required';
		}
		return $field;

	}


}
