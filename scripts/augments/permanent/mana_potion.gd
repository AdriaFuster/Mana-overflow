extends PermanentAugment
class_name ManaPotion

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
	var b_mps = Stats.mod_mps
	b_mps *= _current_increment
	
	return b_mps

func apply_effect() -> void:
	var add_mps_value: float = _calculate_value()
	set_tick_mps_increment(add_mps_value)
	Stats.mod_mps += add_mps_value

func enhance() -> void:
	enhanced = true
	_current_increment = enhanced_increment
	description_replacements["ARG1P"].enhanced = true
	super.enhance()	
	
