extends PermanentAugment
class_name ManaTree

@export var increment: float = 0.05
	
func _calculate_value() -> float:
	var b_mps = Stats.mod_mps
	var idle_aug_amount: int = Inventory.get_n_augments(GlobalEnum.AugmentType.IDLE)
	b_mps *= (increment*idle_aug_amount)
	
	return b_mps
	
	
