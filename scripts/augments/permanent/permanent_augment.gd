extends Augment
class_name PermanentAugment


var tick_mps_increment: float


func on_equip() -> void:
	super.on_equip()


func augment_efect() -> void:
	apply_effect()


func set_tick_mps_increment(value: float) -> void:
	tick_mps_increment = value
