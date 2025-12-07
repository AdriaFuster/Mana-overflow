extends PermanentAugment
class_name CauldronDogma

@export var increment: float
@export var click_increment: float

func _augment_efect() -> void:
	#redoo
	#super.augment_efect()
	
	var new_cauldron_power: float = Stats.cauldron_power
	new_cauldron_power *= click_increment
	Stats.add_cauldron_modifier(name, new_cauldron_power)

func calculate_value() -> float:
	var m_mps = Stats.mod_mps
	m_mps *= increment
	#print("increment = ", m_mps.toAmericanName())
	
	return m_mps


func enhance() -> void:
	enhanced = true
	click_increment = 7
	d_replacements["C_INC_P"][1] = true
	super.enhance()
