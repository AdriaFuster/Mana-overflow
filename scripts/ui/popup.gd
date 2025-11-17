extends Control

@onready var item_pop_up: PopupPanel = %ItemPopUp
@onready var name_label: RichTextLabel = %Name
@onready var description_label: RichTextLabel = %Description
@onready var type_label: RichTextLabel = %Type
@onready var v_box_container: VBoxContainer = %VBoxContainer

const POPUP_X_SIZE: int = 280
const HORIZONTAL_X_PADDING: int = 50
const HORIZONTAL_Y_PADDING: int = 4
const VERTICAL_X_PADDING: int = 20
const VERTICAL_Y_PADDING: int = -5

enum DISTRIBUTION_MODE{
	VERTICAL, 
	HORIZONTAL
}

func _ready() -> void:
	_setup_parent() 
	
func item_popup(slot:Rect2i, item: InventoryItem, mode: DISTRIBUTION_MODE) -> void:
	#print("------------------")
	
	if item == null:
		return

	if item is Upgrade:
		type_label.hide()
	else:
		type_label.show()
		
	_set_value(item)
	
	#print (description_label.size.y)
	var description_line_count :int = description_label.get_line_count()
	var name_line_count: int = name_label.get_line_count()
	
	var type_line_count: int = type_label.get_line_count()
	
	#if item is Upgrade:
		#type_line_count = 0
	
	var text_font_size: int = description_label.get_theme_font_size("bold_font_size")
	
	#print( description_label.get_line_count())
	
	#print ("description_line_count = ", description_line_count*text_font_size)
	
	description_label.custom_minimum_size.y = description_line_count * text_font_size
	name_label.custom_minimum_size.y = name_line_count * text_font_size
	type_label.custom_minimum_size.y = type_line_count * text_font_size
	
	@warning_ignore("integer_division")
	var extra_space: int = text_font_size + int(text_font_size/2)
	
	var total_height = (description_line_count*text_font_size + 
	name_line_count*text_font_size +
	type_line_count*text_font_size + 
	extra_space)
	
	#print ("total_height ", total_height)
	
	item_pop_up.size = Vector2i(POPUP_X_SIZE + 20, total_height)
	
	#print("Mida del popup assignada: ", item_pop_up.size)
	item_pop_up.position = _calculate_popup_position(slot, mode)
	
	#print("Mida final del popup assignada: ", item_pop_up.size)
	item_pop_up.popup()
	
func _calculate_popup_position(slot:Rect2i, mode: DISTRIBUTION_MODE) -> Vector2:
	var correction: Vector2
	
	correction = _correction(slot.size, mode)
	var sub_container = get_tree().root.get_node("Main/CanvasLayer/SubViewportContainer")
	var container_scale = sub_container.size / Vector2(320, 180)
	var global_container_pos = sub_container.get_global_position()

	var final_pos = (global_container_pos + (Vector2(slot.position) * container_scale)) + correction
	
	return final_pos

func _correction(i_size: Vector2i, mode: DISTRIBUTION_MODE) -> Vector2i:
	var mouse_pos = get_global_mouse_position()
	var correction: Vector2i
	
	if mode == DISTRIBUTION_MODE.VERTICAL:
		if mouse_pos.x <= get_viewport_rect().size.x/2:
			correction = Vector2i(i_size.x + VERTICAL_X_PADDING, VERTICAL_Y_PADDING)
		else:
			correction = -Vector2i(item_pop_up.size.x + VERTICAL_X_PADDING, VERTICAL_Y_PADDING)
	else:
		if mouse_pos.y <= get_viewport_rect().size.y/2:
			correction = Vector2i(-HORIZONTAL_X_PADDING, i_size.y + HORIZONTAL_Y_PADDING)
		else:
			correction = -Vector2i(HORIZONTAL_X_PADDING, item_pop_up.size.y + HORIZONTAL_Y_PADDING)

	return correction
	
	
func _setup_parent() -> void:
	var popup_layer = get_tree().root.get_node("Main/PopupLayer")
	
	if item_pop_up.get_parent() != popup_layer:
		item_pop_up.get_parent().remove_child(item_pop_up)
		popup_layer.add_child(item_pop_up)
		
func hide_item_popup() -> void:
	item_pop_up.hide()

func _set_value(item: InventoryItem) -> void:
	if item.locked:
		name_label.text = item.locked_name
		description_label.text = item.locked_description
	else:
		name_label.text = _set_name_effect(item.name)
		description_label.text = item.description.strip_edges()
	
	if item is Augment:
		type_label.text = _set_type_effect(
			GlobalEnum.enum_to_string(GlobalEnum.AugmentType, item.type), 
			item)


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
	
func _set_name_effect(item_name:String) -> String:
	var text: String = item_name
	
	text = "[color=#CCCCCC]" + text + "[/color]"
	
	return text
