extends InventoryItem
class_name Augment

@export var type: GlobalEnum.AugmentType
@export var cd_indicator: bool

var enhanced: bool = false
const ENHANCE_COLOR: Color = Color("#a7a1dc")

signal augment_activated

#REPLACE STRING [var_name, enhanced]
var d_replacements: Dictionary = {
	"CD": [null, false],
	"ARG1": [null, false],
	"ARG1P": [null, false],
	"ARG2": [null, false],
	"ARG2P": [null, false],
	"ARG3": [null, false],
	"ARG3P": [null, false],
	"ARG4": [null, false],
	"ARG4P": [null, false],	
}

func setup() -> void:
	setup_description()


func on_equip() -> void:
	pass
	
func reset() -> void:
	pass

func setup_description() -> void:
	pass
	
func augment_efect() -> float:
	#assert(false, ("No esta definida la funció _augment_efect per l'augment " + name))
	return 0


func _calculate_value() -> float:
	#assert(false, ("No esta definida la funció _calculate_value per l'augment " + name))
	return 0

func is_activated() -> bool:
	return true

func enhance() -> void:
	reset()
	GameEvents.augment_enhanced.emit()
	GameEvents.update_augment_info.emit(self)
		
	
	
func get_description() -> String:
	var d: String = description 
	for r in d_replacements:
		var a: Array = d_replacements[r]
		
		#only take into account the ones that the augment use
		if a[0] != null:
			#if enhanced, we paint the number
			if a[1]:
				d = TextUtils.replace_augment_string(r, a[0], d, self,ENHANCE_COLOR)
			else:
				d = TextUtils.replace_augment_string(r, a[0], d, self)
	
	return d
