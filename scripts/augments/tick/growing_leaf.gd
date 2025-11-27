extends TickAugment
class_name GrowingLeaf

@export var increment: float = 0.1

func on_equip() -> void:
	super.on_equip()
	GameEvents.cauldron_click.connect(_on_cauldron_click)
	
func _calculate_value() -> float:
	var b_mps = Stats.mod_mps
	b_mps *= increment+1
	
	return b_mps


func _on_cauldron_click() -> void:
	cd_cont = int(cd / GameTick.tick_interval)
	_active = false
	
	
