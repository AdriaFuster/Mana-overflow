extends PermanentAugment
class_name Augment5

@export var increment: float = -0.5
@export var click_increment: float = 0.8
	

func _augment_efect() -> void:
	super._augment_efect()
	
	var new_cauldron_power: float = Stats.cauldron_power
	new_cauldron_power *= click_increment
	Stats.add_cauldron_modifier(name, new_cauldron_power)

func _calculate_value() -> Big:
	var m_mps = Big.new(Stats.mod_mps)
	m_mps.multiplyEquals(increment)
	#print("increment = ", m_mps.toAmericanName())
	
	return m_mps
