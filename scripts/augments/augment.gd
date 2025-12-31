extends InventoryItem
class_name Augment

@export var type: GlobalEnum.AugmentType
@export var cd_indicator: bool
@export var weight: int = 1
@export_multiline var extra: String

var enhanced: bool = false
const ENHANCE_COLOR: Color = Color("#a7a1dc")

signal augment_activated

#REPLACE STRING [var_name, enhanced]
var description_replacements: Dictionary = {
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

var extra_replacements: Dictionary = {
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
	if extra != "":
		setup_extra()


func on_equip() -> void:
	pass

func on_unequip() -> void:
	pass
	
func reset() -> void:
	pass

func tick() -> void:
	pass

func setup_description() -> void:
	pass
	
func setup_extra() -> void:
	pass
	
func augment_efect() -> void:
	pass

func apply_effect() -> void:
	pass

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
	for r in description_replacements:
		var a: Array = description_replacements[r]
		
		#only take into account the ones that the augment use
		if a[0] != null:
			#if enhanced, we paint the number
			if a[1]:
				d = TextUtils.replace_augment_string(r, a[0], d, self,ENHANCE_COLOR)
			else:
				d = TextUtils.replace_augment_string(r, a[0], d, self)
	
	return d

func get_extra() -> String:
	var e: String = extra 
	for r in extra_replacements:
		var a: Array = extra_replacements[r]
		
		#only take into account the ones that the augment use
		if a[0] != null:
			#if enhanced, we paint the number
			if a[1]:
				e = TextUtils.replace_augment_string(r, a[0], e, self,ENHANCE_COLOR)
			else:
				e = TextUtils.replace_augment_string(r, a[0], e, self)
	
	return e
