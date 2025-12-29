extends PermanentAugment
class_name PartyCake

@export var increment: float
@export var enchanced_increment: float
var base_increment: float = 0.01
var total_increment: float = 0

@export var upgrades_to_buy: int = 5
var upgrades_bought: int

func on_equip() -> void:
	GameEvents.upgrade_bought.connect(_on_upgrade_bought)
	total_increment = base_increment
	upgrades_bought = upgrades_to_buy
	super.on_equip()

func setup_description() -> void:
	description_replacements["ARG1P"][0] = "total_increment"
	description_replacements["ARG1"][0] = "upgrades_bought"
	description_replacements["ARG2"][0] = "increment"
	

func _calculate_value() -> float:
	var b_mps = Stats.mod_mps
	b_mps *= (total_increment)
	return b_mps
	
func apply_effect() -> void:
	var add_mps_value: float = _calculate_value()
	set_tick_mps_increment(add_mps_value)
	Stats.mod_mps += add_mps_value

func enhance() -> void:
	enhanced = true
	increment = enchanced_increment
	description_replacements["ARG2"][1] = true
	super.enhance()


func _on_upgrade_bought(_u: Upgrade) -> void:
	upgrades_bought -= 1
	if upgrades_bought == 0:
		total_increment += increment/100
		upgrades_bought = upgrades_to_buy
		augment_activated.emit()
