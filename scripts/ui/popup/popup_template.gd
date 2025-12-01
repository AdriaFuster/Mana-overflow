extends Control

@onready var item_pop_up: Panel = %ItemPopUp

@export var augment_popup_scene:PackedScene = preload("uid://domlquui4goku")
@export var upgrade_popup_scene:PackedScene = preload("uid://cwvodr0lwmw07")
@export var reward_popup_scene:PackedScene = preload("uid://domlquui4goku")

func _ready() -> void:
	_setup_parent() 
	hide_item_popup()


func show_popup(type: GlobalEnum.POPUP_TYPE, slot:Rect2i, item: InventoryItem, mode: GlobalEnum.DISTRIBUTION_MODE) -> void:
	var scene_type
	match type:
		GlobalEnum.POPUP_TYPE.AUGMENT:
			scene_type = augment_popup_scene.instantiate()
		GlobalEnum.POPUP_TYPE.UPGRADE:
			scene_type = upgrade_popup_scene.instantiate()
		GlobalEnum.POPUP_TYPE.REWARD:
			scene_type = reward_popup_scene.instantiate()
		
	for c in item_pop_up.get_children():
		c.queue_free()
	
	print(scene_type)
	item_pop_up.add_child(scene_type)
	
	scene_type.item_popup(slot, item, mode)
	

func _setup_parent() -> void:
	var popup_layer = get_tree().root.get_node("Main/PopupLayer")
	
	if item_pop_up.get_parent() != popup_layer:
		item_pop_up.get_parent().remove_child(item_pop_up)
		popup_layer.add_child(item_pop_up)
		
func hide_item_popup() -> void:
	item_pop_up.hide()
