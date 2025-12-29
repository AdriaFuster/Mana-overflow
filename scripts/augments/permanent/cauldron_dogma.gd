extends PermanentAugment
class_name CauldronDogma

@export var increment: float
@export var click_increment: float


func setup_description() -> void:
	description_replacements["ARG1P"][0] = "increment"
	description_replacements["ARG2P"][0] = "click_increment"

func _calculate_value() -> float:
	var new_cauldron_power: float = Stats.cauldron_power
	new_cauldron_power *= click_increment
	Stats.add_cauldron_modifier(name, new_cauldron_power)
	
	var m_mps = Stats.mod_mps
	m_mps *= increment
		
	return m_mps
	
func apply_effect() -> void:
	var add_mps_value: float = _calculate_value()
	set_tick_mps_increment(add_mps_value)
	Stats.mod_mps += add_mps_value
	

func enhance() -> void:
	enhanced = true
	click_increment = 5
	description_replacements["ARG2P"][1] = true
	super.enhance()
