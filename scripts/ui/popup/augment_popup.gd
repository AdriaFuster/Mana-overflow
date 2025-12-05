extends BasePopup

@onready var type_label: RichTextLabel = %Type
@onready var extra_info: RichTextLabel = %ExtraInfo

func _ready() -> void:
	GameEvents.update_augment_info.connect(_on_update_info)

func _set_value(item: Augment) -> void:

	
	name_label.text = TextUtils.bold(_set_name_effect(item.name))
	description_label.text = item.get_description().strip_edges()
	type_label.text = TextUtils.bold(_set_type_effect(
		GlobalEnum.enum_to_string(GlobalEnum.AugmentType, item.type), 
		item))
	extra_info.text = ""
	name_label.update_minimum_size()
	description_label.update_minimum_size()
	type_label.update_minimum_size()
	extra_info.update_minimum_size()
	

func _set_type_effect(item_name:String, item: InventoryItem) -> String:
	var text: String = item_name
	
	if item is Augment:
	
		if item.type == GlobalEnum.AugmentType.CLICK :
			text = "[shake rate=3 level=1][color=#ffaa00]" + text + "[/color][/shake]"	
		elif item.type == GlobalEnum.AugmentType.IDLE:
			text = "[wave amp=2 freq=3][color=#80dfff]" + text + "[/color][/wave]"
		else:
			text = "[color=#32a852]" + text + "[/color]"
	
	return text


func _on_update_info(a: Augment) -> void:
	_set_value(a)
	
	
	
	
	
	
