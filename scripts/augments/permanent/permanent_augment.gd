extends Augment
class_name PermanentAugment


var tick_mps_increment: float


func on_equip() -> void:
	super.on_equip()
	#_augment_efect()


func augment_efect() -> float:
	return _calculate_value()
