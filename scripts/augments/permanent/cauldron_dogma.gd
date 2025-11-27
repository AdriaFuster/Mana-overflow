extends PermanentAugment
class_name CauldronDogma

@export var increment: float = -0.5
@export var click_increment: float = 0.8
	

func _augment_efect() -> void:
	super._augment_efect()
	
	var new_cauldron_power: float = Stats.cauldron_power
	new_cauldron_power *= click_increment
	Stats.add_cauldron_modifier(name, new_cauldron_power)

func _calculate_value() -> float:
	var m_mps = Stats.mod_mps
	m_mps *= increment
	#print("increment = ", m_mps.toAmericanName())
	
	return m_mps
