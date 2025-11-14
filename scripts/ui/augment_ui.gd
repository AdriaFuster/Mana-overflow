extends Control
class_name AugmentUI

@onready var icon: TextureRect = $UI/TextureRect
@onready var cd: Label = $Cd
var augment: Augment

func setup(a: Augment) -> void:
	augment = a
	icon.texture = a.icon

	#if !augment.permanent:
		#cd.text = str(augment.cd)
	#else:
		#cd.text = "∞"
	
	
func _process(_delta: float) -> void:
	if augment is TickAugment:
		if snapped(augment.cd_cont*GameTick.tick_interval,1) == 0:
			cd.text = str(snapped(augment.cd,1))
		else:
			cd.text = str(snapped(augment.cd_cont*GameTick.tick_interval,1))
	else:
		cd.text = str(augment.cd_cont)

func _on_mouse_entered() -> void:
	ItemPopup.item_popup(Rect2i(Vector2i(global_position), Vector2i(size)), 
	augment, ItemPopup.DISTRIBUTION_MODE.HORIZONTAL)


func _on_mouse_exited() -> void:
	ItemPopup.hide_item_popup()
