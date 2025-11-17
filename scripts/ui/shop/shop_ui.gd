extends Control
class_name ShopUI

@onready var shop_panel: Panel = %ShopPanel
@onready var augment_list: HBoxContainer = %AugmentList
@onready var canvas_layer: CanvasLayer = %CanvasLayer


var a_ui_scene: PackedScene = preload("uid://c8dnhp81ld2hm")

signal augment_bought


func show_shop() -> void:
	set_shop_size()
	
	set_aguments()
	
	show()
	canvas_layer.show()


func set_aguments() -> void:
	#for c in augment_list.get_children():
		#c.queue_free()
	
	var augments_keys = Shop.augments.keys()
	
	var slots: Array = augment_list.get_children()
	
	for i in slots.size():
		var item: ShopItem = slots[i]
		var augment: Augment = Shop.augments[augments_keys[i]]
		item.setup(augment)
	

func set_shop_size() -> void:
	var a_ui: AugmentUI = a_ui_scene.instantiate() as AugmentUI
	shop_panel.size = Vector2(180, 90)#get_viewport_rect().size/2
	augment_list.size.y = a_ui.get_minimum_size().y
	
	#shop_panel.set_anchors_preset(Control.PRESET_CENTER)
		

func hide_shop() -> void:
	canvas_layer.hide()
	hide()
