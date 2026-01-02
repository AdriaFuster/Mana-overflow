extends PermanentAugment
class_name CeremonialHammer

@export var increment: float
@export var enhanced_increment: float
var _current_increment: float

func setup() -> void:
	_current_increment = increment
	super.setup()

func setup_description() -> void:
	description_replacements["ARG1P"].variable = "increment"
	description_replacements["ARG1P"].enhanced_variable = "enhanced_increment"


func _calculate_value() -> float:
	var b_cp = Stats.cp
	b_cp *= _current_increment
	
	return b_cp

func apply_effect() -> void:
	var cp_add_value: float = _calculate_value()
	Stats.mod_cp += cp_add_value
	set_tick_mps_increment(0)


func enhance() -> void:
	enhanced = true
	_current_increment = enhanced_increment
	description_replacements["ARG1P"].enhanced = true
	super.enhance()	
	
