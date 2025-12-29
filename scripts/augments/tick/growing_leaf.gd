extends TickAugment
class_name GrowingLeaf

@export var increment: float

func on_equip() -> void:
	super.on_equip()
	GameEvents.cauldron_click.connect(_on_cauldron_click)
	
func setup_description() -> void:
	description_replacements["ARG1P"][0] = "increment"
	description_replacements["CD"][0] = "cd"
	
func _calculate_value() -> float:
	var b_mps = Stats.mod_mps
	b_mps *= increment+1
	
	return b_mps


func _on_cauldron_click() -> void:
	cd_cont = int(cd / GameTick.tick_interval)
	_active = false
	

func enhance() -> void:
	enhanced = true
	increment = 0.6
	cd = 3
	description_replacements["ARG1P"][1] = true
	description_replacements["CD"][1] = true
	super.enhance()
