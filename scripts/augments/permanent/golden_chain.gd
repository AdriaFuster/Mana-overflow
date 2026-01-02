extends PermanentAugment
class_name GoldenChain

@export var cost_increment: float
@export var enhanced_cost_increment: float
var _current_cost_increment: float

@export var mps_increment: float

func setup() -> void:
	_current_cost_increment = cost_increment
	super.setup()

func on_equip() -> void:
	Inventory.add_upgrade_discount(name, _current_cost_increment)
	super.on_equip()

func on_unequip() -> void:
	Inventory.remove_upgrade_discount(name)

func setup_description() -> void:
	description_replacements["ARG1P"].variable = "cost_increment"
	description_replacements["ARG1P"].enhanced_variable = "enhanced_cost_increment"

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
	_current_cost_increment = enhanced_cost_increment
	description_replacements["ARG1P"].enhanced = true
	Inventory.add_upgrade_discount(name, _current_cost_increment)
	super.enhance()	
	
