extends BasePopup

func _set_value(item: InventoryItem) -> void:

	name_label.text = _set_name_effect(item.name)
	description_label.text = item.description.strip_edges()


func _set_type_effect(item_name:String, item: InventoryItem) -> String:
	var text: String = item_name
	
	if item is Augment:
	
		if item.type == GlobalEnum.AugmentType.CLICK :
			text = "[shake rate=3 level=1][color=#ffaa00][b]" + text + "[/b][/color][/shake]"	
		elif item.type == GlobalEnum.AugmentType.IDLE:
			text = "[wave amp=2 freq=3][color=#80dfff]" + text + "[/color][/wave]"
		else:
			text = "[color=#32a852]" + text + "[/color]"
	
	return text
