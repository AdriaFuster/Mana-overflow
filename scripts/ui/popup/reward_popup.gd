extends BasePopup

func _set_value(item: Reward) -> void:

	name_label.text = TextUtils.bold(item.name)
	description_label.text = item.description
