extends BasePopup

@onready var lvl: RichTextLabel = %Lvl
const lvl_prefix = "LVL "


func _ready() -> void:
	GameEvents.update_info.connect(_on_update_info)

func _set_value(item: Upgrade) -> void:
	
	if item.locked:
		name_label.text = TextUtils.bold(item.locked_name)
		description_label.text = item.locked_description
		lvl.hide()
	else:
		name_label.text = TextUtils.bold(item.name)
		description_label.text = item.get_description()
		
		lvl.show()
		lvl.text = TextUtils.bold(item.get_lvl(lvl_prefix))


func _on_update_info(u: Upgrade) -> void:
	_set_value(u)
