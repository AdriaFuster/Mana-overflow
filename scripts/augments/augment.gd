extends InventoryItem
class_name Augment

@export var type: GlobalEnum.AugmentType
@export var icon: Texture2D

var cd_cont: int
var active_cont: int

func setup() -> void:
	_replace_texts()


func on_equip() -> void:
	pass
	
	
func reset() -> void:
	cd_cont = 0
	active_cont = 0
	
	
func _augment_efect() -> void:
	#assert(false, ("No esta definida la funció _augment_efect per l'augment " + name))
	pass


func _calculate_value() -> Big:
	#assert(false, ("No esta definida la funció _calculate_value per l'augment " + name))
	return
	
	
func _replace_texts() -> void:

	description = _replace_string("INC_P", "increment", description)
	description = _replace_string("INC_F", "increment", description)
	description = _replace_string("CD", "cd", description)
	description = _replace_string("C_INC_P", "click_increment", description)
	description = _replace_string("C_INC_F", "click_increment", description)
	description = _replace_string("N_CLICKS", "cd", description)
	description = _replace_string("REFUND_P", "refund", description)

func _replace_string(replace_string: String, var_name: String, text: String ) -> String:
	
	var dollar_replace_string = "$"+replace_string+"$"
	var new_text := text
	
	if dollar_replace_string not in text or get(var_name) == null:
		return new_text
	
	var var_value: float = get(var_name)
	
	if replace_string.ends_with("_P"):
		var_value *= 100
	
	#No decimals
	if var_value == floor(var_value):
		new_text = text.replace(dollar_replace_string, str(int(var_value)))
	#Decimal
	else:
		new_text = text.replace(dollar_replace_string, str(var_value))
	return new_text
