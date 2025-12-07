extends Augment
class_name ClickAugment

@export var cd: int
var cd_cont: int


func on_equip() -> void:
	super.on_equip()
	GameEvents.cauldron_click.connect(_on_cauldron_click)
	cd_cont = cd

func reset() -> void:
	super.reset()
	cd_cont = cd

func _on_cauldron_click() -> void:
	cd_cont -= 1
	#print ("augment ", name, " click and have ", cd_cont, "cd")
	if cd_cont == 0:
		augment_efect()
