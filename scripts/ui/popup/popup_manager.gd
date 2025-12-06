extends Node

var popup_template: PopupTemplate
var popup_template_type = {
 	GlobalEnum.POPUP_TYPE.AUGMENT: preload("uid://domlquui4goku"),
	GlobalEnum.POPUP_TYPE.UPGRADE: preload("uid://cwvodr0lwmw07"),
	GlobalEnum.POPUP_TYPE.REWARD: preload("uid://rab4w4idww15"),
	GlobalEnum.POPUP_TYPE.MPS: preload("uid://k1cgxgtlmwbv")
}

func _ready() -> void:
	popup_template = PopupTemplate.new()
	_setup_popup_parent()
	
	
func _setup_popup_parent() -> void:
	var popup_layer = get_tree().root.get_node("Main/PopupLayer")
	
	if popup_template.get_parent() != popup_layer:
		popup_layer.add_child(popup_template)

func show_popup(type: GlobalEnum.POPUP_TYPE, slot:Rect2i, mode: GlobalEnum.DISTRIBUTION_MODE, item: Variant) -> void:
	var scene: PackedScene = popup_template_type.get(type)
	if scene == null:
		push_error("Popup type not registered: %s" % GlobalEnum.enum_to_string(GlobalEnum.POPUP_TYPE,type))
		return
		
	var popup = scene.instantiate()
	
	popup_template.remove_children()
	
	popup_template.add_child(popup)
		
	popup_template.show_popup(popup, slot, mode, item)
	
func hide_popup() -> void:
	popup_template.hide()
	
