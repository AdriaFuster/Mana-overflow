extends PermanentAugment
class_name SpellBook

@export var mps_increment: float
@export var enhanced_mps_increment: float
var current_mps_increment: float
@export var cp_increment: float
var current_cp_increment: float

func setup() -> void:
	current_mps_increment = mps_increment
	current_cp_increment = cp_increment
	super.setup()

func setup_description() -> void:
	description_replacements["ARG1P"].variable = "mps_increment"
	description_replacements["ARG1P"].enhanced_variable = "enhanced_mps_increment"
	description_replacements["ARG2P"].variable = "cp_increment"


func _calculate_value() -> float:
	var b_mps = Stats.mod_mps
	b_mps *= current_mps_increment
	
	return b_mps


func apply_effect() -> void:
	var add_mps_value: float = _calculate_value()
	set_tick_mps_increment(add_mps_value)
	Stats.mod_mps += add_mps_value
	Stats.mod_cp += current_cp_increment*Stats.mod_cp

func enhance() -> void:
	enhanced = true
	current_mps_increment = enhanced_mps_increment
	description_replacements["ARG1P"].enhanced = true
	super.enhance()	
	
