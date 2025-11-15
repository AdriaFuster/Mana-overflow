extends Augment
class_name ClickAugment

@export var cd: float

func on_equip() -> void:
	super.on_equip()
	GameEvents.cauldron_click.connect(_on_cauldron_click)
	cd_cont = int(cd)


func _on_cauldron_click() -> void:
	cd_cont -= 1
	#print ("augment ", name, " click and have ", cd_cont, "cd")
	if cd_cont == 0:
		_augment_efect()
	
	
