extends TickAugment
class_name Augment1

@export var increment: float = 0.1

func on_equip() -> void:
	super.on_equip()
	GameEvents.cauldron_click.connect(_on_cauldron_click)
	
#Add 2% of the MPS for the next tick	
func _calculate_value() -> Big:
	var b_mps = Big.new(Stats.mps)
	b_mps.multiplyEquals(increment+1)
	
	return b_mps


func _on_cauldron_click() -> void:
	_cd_cont = seconds_cd
	_active = false
	
	
