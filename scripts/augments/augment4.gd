extends ClickAugment
class_name Augment4

@export var increment: float = 1
	

#Each 10 clicks, next one +100% click power
func _calculate_value() -> Big:
	var b_mps = Big.new(Stats.cauldron_power)
	b_mps.multiplyEquals(increment)
	
	return b_mps

func _augment_efect() -> void:
	
	var value: Big = Big.new(_calculate_value())
	print("augment_efect with value = ", value.toAmericanName())
	
	#Encapsular-ho a una funcio a Stats
	Stats.mana.plusEquals(value)
	
	_click_cont = click_cd
