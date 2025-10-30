extends Augment
class_name Augment2

@export var efect_increment: float = 5


func _ready() -> void:
	super._ready()
	upgrade_efect()
	
	
func upgrade_efect() -> void:
	Stats.add_percent_modifier(augment_res.name,efect_increment, augment_res.tick_duration, 
								Stats.MODIFIER_TYPE.MPS, augment_res.permanent)


	
	
