extends PermanentAugment
class_name ManaTree

@export var increment: float
	
func setup_description() -> void:
	d_replacements["ARG1P"][0] = "increment"

func _calculate_value() -> float:
	var b_mps = Stats.mod_mps
	var idle_aug_amount: int = Inventory.get_n_augments(GlobalEnum.AugmentType.IDLE)
	b_mps *= (increment*idle_aug_amount)
	return b_mps
	

func enhance() -> void:
	enhanced = true
	increment = 0.5
	d_replacements["ARG1P"][1] = true
	super.enhance()
