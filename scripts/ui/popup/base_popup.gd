extends Control
class_name BasePopup

@onready var item_pop_up: Panel = %ItemPopUp
@onready var v_box_container: VBoxContainer = %VBoxContainer
@onready var name_label: RichTextLabel = %Name
@onready var description_label: RichTextLabel = %Description


const POPUP_X_SIZE: int = 300
const POPUP_MARGINS: int = 20
const HORIZONTAL_X_PADDING: int = -2
const HORIZONTAL_Y_PADDING: int = 4
const VERTICAL_X_PADDING: int = 0#20
const VERTICAL_Y_PADDING: int = 0#-5

enum DISTRIBUTION_MODE{
	VERTICAL, 
	HORIZONTAL
}

func _ready() -> void:
	_setup_parent() 
	hide_item_popup()
	
func item_popup(slot:Rect2i, item: InventoryItem, mode: DISTRIBUTION_MODE) -> void:
	#print("------------------")
	
	if item == null:
		return

	_set_value(item)
		
	#Wait 2 times for rich label
	#await get_tree().process_frame
	#await get_tree().process_frame
	
	var content_y_size = v_box_container.get_combined_minimum_size().y
	item_pop_up.size = Vector2(POPUP_X_SIZE + POPUP_MARGINS, content_y_size + POPUP_MARGINS)	
	
	item_pop_up.position = _calculate_popup_position(slot, mode)
	
	item_pop_up.show()
	
	
func _calculate_popup_position(slot:Rect2i, mode: DISTRIBUTION_MODE) -> Vector2:
	var correction: Vector2

	correction = _correction(slot.size, mode)
	var sub_container = get_tree().root.get_node("Main/SceneManager/CanvasLayer/SubViewportContainer")
	var container_scale = sub_container.size / Vector2(320, 180)
	var global_container_pos = sub_container.get_global_position()

	var final_pos = (global_container_pos + (Vector2(slot.position) * container_scale)) + correction
	
	return final_pos

func _correction(i_size: Vector2i, mode: DISTRIBUTION_MODE) -> Vector2i:
	var mouse_pos = get_global_mouse_position()
	var correction: Vector2
	
	if mode == DISTRIBUTION_MODE.VERTICAL:
		if mouse_pos.x <= get_viewport_rect().size.x/2:
			correction = Vector2i(i_size.x + VERTICAL_X_PADDING, VERTICAL_Y_PADDING)
		else:
			correction = -Vector2(item_pop_up.size.x + VERTICAL_X_PADDING, VERTICAL_Y_PADDING)
	else:
		if mouse_pos.y <= get_viewport_rect().size.y/2:
			correction = Vector2(-HORIZONTAL_X_PADDING, i_size.y + HORIZONTAL_Y_PADDING)
		else:
			correction = -Vector2(HORIZONTAL_X_PADDING, item_pop_up.size.y + HORIZONTAL_Y_PADDING)

	return correction
	
	
func _setup_parent() -> void:
	var popup_layer = get_tree().root.get_node("Main/PopupLayer")
	
	if item_pop_up.get_parent() != popup_layer:
		item_pop_up.get_parent().remove_child(item_pop_up)
		popup_layer.add_child(item_pop_up)
		
func hide_item_popup() -> void:
	item_pop_up.hide()

	
func _set_name_effect(item_name:String) -> String:
	var text: String = item_name
	
	text = "[color=#CCCCCC]" + text + "[/color]"
	
	return text
	

func _set_value(_item: InventoryItem) -> void:
	pass
