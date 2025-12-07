extends InventoryItem
class_name Augment

@export var type: GlobalEnum.AugmentType

var enhanced: bool = false
const ENHANCE_COLOR: Color = Color("#a7a1dc")

signal augment_activated

#REPLACE STRING [var_name, enhanced]
var d_replacements: Dictionary = {
	"INC_P": ["increment", false],
	"INC_F": ["increment", false],
	"CD": ["cd", false],
	"C_INC_P": ["click_increment", false],
	"C_INC_F": ["click_increment", false],
	"N_CLICKS": ["cd", false],
	"REFUND_P": ["refund", false],	
}

func setup() -> void:
	pass

func on_equip() -> void:
	pass
	
func reset() -> void:
	pass
	
	
func augment_efect() -> float:
	#assert(false, ("No esta definida la funció _augment_efect per l'augment " + name))
	return 0


func _calculate_value() -> float:
	#assert(false, ("No esta definida la funció _calculate_value per l'augment " + name))
	return 0


func enhance() -> void:
	reset()
	GameEvents.augment_enhanced.emit()
	GameEvents.update_augment_info.emit(self)
		
	
	
func get_description() -> String:
	var d: String = description 
	for r in d_replacements:
		var a: Array = d_replacements[r]
		#if enhanced, we paint the number
		if a[1]:
			d = TextUtils.replace_augment_string(r, a[0], d, self,ENHANCE_COLOR)
		else:
			d = TextUtils.replace_augment_string(r, a[0], d, self)
	
	return d
