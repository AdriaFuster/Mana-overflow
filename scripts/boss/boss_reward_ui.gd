extends Control
class_name BossRewardUI

@onready var reward_panel: Panel = %RewardPanel
@onready var reward_list: HBoxContainer = %RewardList
@onready var canvas_layer: CanvasLayer = %CanvasLayer


var r_ui_scene: PackedScene = preload("uid://dvo6qlj00vaqk")


func show_ui() -> void:
	set_ui_size()
	
	set_rewards()
	
	show()
	canvas_layer.show()


func set_rewards() -> void:
	#for c in augment_list.get_children():
		#c.queue_free()
	
	var augments_keys = Shop.augments.keys()
	
	#var slots: Array = augment_list.get_children()
	#
	#for i in slots.size():
		#var item: ShopItem = slots[i]
		#var augment: Augment = Shop.augments[augments_keys[i]]
		#item.setup(augment)
	

func set_ui_size() -> void:
	#var r_ui: AugmentUI = a_ui_scene.instantiate() as AugmentUI
	reward_panel.size = Vector2(180, 90)#get_viewport_rect().size/2
	#augment_list.size.y = a_ui.get_minimum_size().y
	
		

func hide_shop() -> void:
	canvas_layer.hide()
	hide()
