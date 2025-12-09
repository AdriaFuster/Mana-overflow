extends Augment
class_name PermanentAugment


var tick_mps_increment: float


func on_equip() -> void:
	super.on_equip()


func augment_efect() -> float:
	var value: float = _calculate_value()
	tick_mps_increment = value

	return value
