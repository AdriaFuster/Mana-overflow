extends ClickAugment
class_name MightyForce

@export var increment: float = 1
	

#Each 10 clicks, next one +100% click power
func _calculate_value() -> float:
	var b_mps = Stats.mod_cauldron_power
	b_mps *= increment
	
	return b_mps

func _augment_efect() -> void:
	
	var value: float = _calculate_value()
	
	Stats.add_mana(value)
	
	cd_cont = int(cd)
