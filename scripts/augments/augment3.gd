extends TickAugment
class_name Augment3

@export var increment: float = 0.01
	
#Add 1% per IDLE augment
func _calculate_value() -> Big:
	var b_mps = Big.new(Stats.mod_mps)
	var idle_aug_amount = Inventory.get_n_augments(GlobalEnum.AugmentType.IDLE)
	b_mps.multiplyEquals(increment*idle_aug_amount)
	
	return b_mps
	
	
