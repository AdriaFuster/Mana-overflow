extends Augment
class_name ClickAugment


@export var click_cd: int

var _click_cont: float

func on_equip() -> void:
	cd = click_cd
	GameEvents.cauldron_click.connect(_on_cauldron_click)
	_click_cont = cd


func _on_cauldron_click() -> void:
	_click_cont -= 1
	print ("augment ", name, " click and have ", _click_cont, "cd")
	
	if _click_cont == 0:
		_augment_efect()
	
	
