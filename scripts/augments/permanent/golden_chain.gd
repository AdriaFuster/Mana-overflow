extends PermanentAugment
class_name GoldenChain

@export var cost_increment: float
@export var enhanced_cost_increment: float
@export var mps_increment: float

func on_equip() -> void:
	Inventory.add_upgrade_discount(name, cost_increment)
	super.on_equip()

func on_unequip() -> void:
	Inventory.remove_upgrade_discount(name)

func setup_description() -> void:
	description_replacements["ARG1P"][0] = "cost_increment"

func _calculate_value() -> float:
	var b_mps = Stats.mod_mps
	b_mps *= mps_increment
	
	return b_mps


func apply_effect() -> void:
	var add_mps_value: float = _calculate_value()
	set_tick_mps_increment(add_mps_value)
	Stats.mod_mps += add_mps_value

func enhance() -> void:
	enhanced = true
	cost_increment = enhanced_cost_increment
	description_replacements["ARG1P"][1] = true
	Inventory.add_upgrade_discount(name, cost_increment)
	super.enhance()	
	
