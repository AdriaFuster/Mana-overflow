extends PermanentAugment
class_name SaversPouch

@export var increment: float
@export var enchanced_increment: float
var _mana_saved: float = 0

func on_equip() -> void:
	GameEvents.upgrade_bought.connect(_on_upgrade_bought)
	super.on_equip()

func setup_description() -> void:
	description_replacements["ARG1P"][0] = "increment"
	

func _calculate_value() -> float:
	return _mana_saved
	
func apply_effect() -> void:
	var add_mps_value: float = _calculate_value()
	set_tick_mps_increment(add_mps_value)
	Stats.mod_mps += add_mps_value

func enhance() -> void:
	enhanced = true
	increment = enchanced_increment
	description_replacements["ARG1P"][1] = true
	super.enhance()


func _on_upgrade_bought(u: Upgrade) -> void:
	var u_cost: float = u.cost
	var extra_mps: float = u_cost * increment 
	_mana_saved += extra_mps
	
	
