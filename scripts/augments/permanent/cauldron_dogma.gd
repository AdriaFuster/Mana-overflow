extends PermanentAugment
class_name CauldronDogma

@export var increment: float
@export var click_increment: float
@export var enhanced_click_increment: float
var _current_click_increment: float

func setup() -> void:
	_current_click_increment = click_increment
	super.setup()

func setup_description() -> void:
	description_replacements["ARG1P"].variable = "increment"
	description_replacements["ARG2P"].variable = "click_increment"
	description_replacements["ARG2P"].enhanced_variable = "enhanced_click_increment"

func _calculate_value() -> float:
	var new_cp: float = Stats.cp
	new_cp *= _current_click_increment
	Stats.add_cauldron_modifier(name, new_cp)
	
	var m_mps = Stats.mod_mps
	m_mps *= increment
		
	return m_mps
	
func apply_effect() -> void:
	var add_mps_value: float = _calculate_value()
	set_tick_mps_increment(add_mps_value)
	Stats.mod_mps += add_mps_value
	

func enhance() -> void:
	enhanced = true
	_current_click_increment = enhanced_click_increment
	description_replacements["ARG2P"].enhanced = true
	super.enhance()
