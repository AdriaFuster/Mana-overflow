extends Control
class_name BasePopup

@onready var v_box_container: VBoxContainer = %VBoxContainer
@onready var name_label: RichTextLabel = %Name
@onready var description_label: RichTextLabel = %Description


#const POPUP_X_SIZE: int = 120
const POPUP_MARGINS: int = 20
const HORIZONTAL_X_PADDING: int = 0
const HORIZONTAL_Y_PADDING: int = 5
const VERTICAL_X_PADDING: int = 5
const VERTICAL_Y_PADDING: int = 0

	
func item_popup(slot:Rect2i, mode: GlobalEnum.DISTRIBUTION_MODE, item: Variant) -> void:
	_set_value(item)

	call_deferred("_calculate_popup_position",slot,mode)
	
	show()
	
	
func _calculate_popup_position(slot:Rect2i, mode: GlobalEnum.DISTRIBUTION_MODE) -> void:
	var correction: Vector2
	correction = _correction(slot.size, mode)
	var final_pos = (Vector2(slot.position)) + correction
	
	position = final_pos

func _correction(i_size: Vector2i, mode: GlobalEnum.DISTRIBUTION_MODE) -> Vector2i:
	var mouse_pos = get_global_mouse_position()
	var correction: Vector2
	
	if mode == GlobalEnum.DISTRIBUTION_MODE.VERTICAL:
		if mouse_pos.x <= get_viewport_rect().size.x/2:
			correction = Vector2i(i_size.x + VERTICAL_X_PADDING, VERTICAL_Y_PADDING)
		else:
			correction = -Vector2(size.x + VERTICAL_X_PADDING, VERTICAL_Y_PADDING)
	else:
		if mouse_pos.y <= get_viewport_rect().size.y/2:
			correction = Vector2(-HORIZONTAL_X_PADDING, i_size.y + HORIZONTAL_Y_PADDING)
		else:
			correction = -Vector2(HORIZONTAL_X_PADDING, size.y + HORIZONTAL_Y_PADDING)

	return correction
	
	
func _set_name_effect(item_name:String) -> String:
	var text: String = item_name
	
	text = "[color=#CCCCCC]" + text + "[/color]"
	
	return text
	

func _set_value(_item) -> void:
	pass
