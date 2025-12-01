extends BaseMenu
class_name ShopMenu

var item_scene: PackedScene = preload("uid://bar52tocqunyw")

func set_slots() -> void:
	for i in slot_amount:
		var item: ShopItem = item_scene.instantiate()
		item_list.add_child(item)

func set_items() -> void:
	var augments_keys = Shop.augments.keys()
	
	var slots: Array = item_list.get_children()
	
	for i in slots.size():
		var item: ShopItem = slots[i]
		var augment: Augment = Shop.augments[augments_keys[i]]
		item.setup(augment)
	

func set_menu_size() -> void:
	pass
	#var slot_scene: ShopItem = slot_scene.instantiate() as ShopItem
	#panel.size = Vector2(180, 90)#get_viewport_rect().size/2
	#item_list.size.y = slot_scene.get_minimum_size().y
	
	#shop_panel.set_anchors_preset(Control.PRESET_CENTER)
	
