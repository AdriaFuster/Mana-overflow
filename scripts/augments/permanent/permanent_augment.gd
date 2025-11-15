extends Augment
class_name PermanentAugment


func on_equip() -> void:
	_augment_efect()


func tick() -> void:
	_augment_efect()


func _augment_efect() -> void:
	var value: Big = Big.new(_calculate_value())
	Stats.add_permanent_modifier(name,value,Stats.MODIFIER_TYPE.MPS)
