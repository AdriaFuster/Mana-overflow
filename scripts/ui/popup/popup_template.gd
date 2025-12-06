extends Control
class_name PopupTemplate

@export var augment_popup_scene:PackedScene = preload("uid://domlquui4goku")
@export var upgrade_popup_scene:PackedScene = preload("uid://cwvodr0lwmw07")
@export var reward_popup_scene:PackedScene = preload("uid://domlquui4goku")

var augment_scene: BasePopup
var upgrade_scene: BasePopup
var reward_scene: BasePopup

func _ready() -> void:
	hide_popup()


func show_popup(popup: BasePopup, slot:Rect2i, mode: GlobalEnum.DISTRIBUTION_MODE,item: InventoryItem) -> void:

	show()
	popup.item_popup(slot, mode, item)
	
		
func hide_popup() -> void:
	hide()


func remove_children() -> void:
	for c in get_children():
		c.queue_free()
