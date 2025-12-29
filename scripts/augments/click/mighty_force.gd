extends ClickAugment
class_name MightyForce

@export var increment: float
	

func setup_description() -> void:
	description_replacements["CD"][0] = "cd"
	description_replacements["ARG1P"][0] = "increment"

func _calculate_value() -> float:
	var b_mps = Stats.mod_cauldron_power
	b_mps *= increment
	
	return b_mps

func augment_efect() -> void:
	
	var value: float = _calculate_value()
	
	Stats.add_mana(value)
	
	cd_cont = int(cd)

func enhance() -> void:
	enhanced = true
	cd = 8
	increment = 3
	description_replacements["CD"][1] = true
	description_replacements["ARG1P"][1] = true
	super.enhance()
