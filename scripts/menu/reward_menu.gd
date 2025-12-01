extends BaseMenu
class_name RewardMenu

var item_scene: PackedScene = preload("uid://dvo6qlj00vaqk")

func set_slots() -> void:
	for i in slot_amount:
		var item: RewardItem = item_scene.instantiate()
		item_list.add_child(item)

func set_items() -> void:
	var rewards_keys = RewardManager.rewards.keys()
	
	var slots: Array = item_list.get_children()
	
	for i in slots.size():
		var item: RewardItem = slots[i]
		var reward: Reward = RewardManager.rewards[rewards_keys[i]]
		item.setup(reward)
	

func set_menu_size() -> void:
	pass
	#var slot_scene: ShopItem = slot_scene.instantiate() as ShopItem
	#panel.size = Vector2(180, 90)#get_viewport_rect().size/2
	#item_list.size.y = slot_scene.get_minimum_size().y
	
	#shop_panel.set_anchors_preset(Control.PRESET_CENTER)
	
func select_reward() -> void:
	await GameEvents.reward_selected

	
	
	
	
	
