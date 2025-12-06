extends Control
class_name BasePopup

@onready var v_box_container: VBoxContainer = %VBoxContainer
@onready var name_label: RichTextLabel = %Name
@onready var description_label: RichTextLabel = %Description


const POPUP_X_SIZE: int = 300
const POPUP_MARGINS: int = 20
const HORIZONTAL_X_PADDING: int = -2
const HORIZONTAL_Y_PADDING: int = 4
const VERTICAL_X_PADDING: int = 15
const VERTICAL_Y_PADDING: int = -4

	
func item_popup(slot:Rect2i, mode: GlobalEnum.DISTRIBUTION_MODE, item: Variant) -> void:

	_set_value(item)
		
	#Wait 2 times for rich label
	#await get_tree().process_frame
	#await get_tree().process_frame
	
	var content_y_size = v_box_container.get_combined_minimum_size().y
	size = Vector2(POPUP_X_SIZE + POPUP_MARGINS, content_y_size + POPUP_MARGINS)	
	
	position = _calculate_popup_position(slot, mode)
	show()
	
	
func _calculate_popup_position(slot:Rect2i, mode: GlobalEnum.DISTRIBUTION_MODE) -> Vector2:
	var correction: Vector2

	correction = _correction(slot.size, mode)
	var sub_container = get_tree().root.get_node("Main/SceneManager/CanvasLayer/SubViewportContainer")
	var container_scale = sub_container.size / Vector2(320, 180)
	var global_container_pos = sub_container.get_global_position()

	var final_pos = (global_container_pos + (Vector2(slot.position) * container_scale)) + correction
	
	return final_pos

func _correction(i_size: Vector2i, mode: GlobalEnum.DISTRIBUTION_MODE) -> Vector2i:
	var mouse_pos = get_global_mouse_position()
	var correction: Vector2
	print ("i_size = ",i_size)
	if mode == GlobalEnum.DISTRIBUTION_MODE.VERTICAL:
		if mouse_pos.x <= get_viewport_rect().size.x/2:
			print("part esquerra de la pantalla")
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
