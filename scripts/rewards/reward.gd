extends InventoryItem
class_name Reward


func reward_effect() -> void:	
	GameEvents.reward_selected.emit()
