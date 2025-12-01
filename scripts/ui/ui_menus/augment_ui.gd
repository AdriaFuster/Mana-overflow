extends Control
class_name AugmentUI

@onready var icon: TextureRect = $UI/TextureRect
@onready var cd: Label = $Cd
@onready var permanent: TextureRect = $permanent


var augment: Augment

func setup(a: Augment) -> void:
	augment = a
	icon.texture = a.icon
	
	if augment is PermanentAugment:
		cd.hide()
		permanent.show()
	else:
		cd.show()
		permanent.hide()
	
func _process(_delta: float) -> void:
	if augment is TickAugment:
		if snapped(augment.cd_cont*GameTick.tick_interval,1) == 0:
			cd.text = str(snapped(augment.cd,1))
		else:
			cd.text = str(snapped(augment.cd_cont*GameTick.tick_interval,1))
	else:
		cd.text = str(augment.cd_cont)

func _show_popup() -> void:
	PopupTemplate.show_popup(GlobalEnum.POPUP_TYPE.AUGMENT,
	Rect2i(Vector2i(global_position), Vector2i(size)), 
	augment, 
	GlobalEnum.DISTRIBUTION_MODE.HORIZONTAL)

func _on_mouse_entered() -> void:
	_show_popup()
	


func _on_mouse_exited() -> void:
	PopupTemplate.hide_item_popup()
	
	
