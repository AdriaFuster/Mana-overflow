extends PermanentAugment
class_name PartyCake

@export var base_increment: float = 0.01
@export var increment: float
@export var enchanced_increment: float
var _current_increment: float
var total_increment: float = 0

@export var upgrades_to_buy: int = 5
var upgrades_bought: int

func setup() -> void:
	_current_increment = increment
	total_increment = base_increment
	upgrades_bought = upgrades_to_buy
	super.setup()

func on_equip() -> void:
	GameEvents.upgrade_bought.connect(_on_upgrade_bought)
	super.on_equip()

func setup_description() -> void:
	description_replacements["ARG1P"].variable = "total_increment"
	description_replacements["ARG1"].variable = "upgrades_bought"
	description_replacements["ARG2"].variable = "increment"
	description_replacements["ARG2"].enhanced_variable = "enchanced_increment"
	

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
	_current_increment = enchanced_increment
	description_replacements["ARG2"].enhanced = true
	super.enhance()


func _on_upgrade_bought(_u: Upgrade) -> void:
	upgrades_bought -= 1
	if upgrades_bought == 0:
		total_increment += _current_increment/100
		upgrades_bought = upgrades_to_buy
		augment_activated.emit()
