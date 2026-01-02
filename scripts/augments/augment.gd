extends InventoryItem
class_name Augment

@export var type: GlobalEnum.AugmentType
@export var cd_indicator: bool
@export var weight: int = 1
@export_multiline var extra: String

var enhanced: bool = false
const ENHANCE_COLOR: Color = Color("#a7a1dc")

signal augment_activated

class ReplacementData:
	var variable: String = ""
	var enhanced_variable: String = ""
	var enhanced: bool = false
	

#REPLACE STRING [var_name,enhanced_var_name, enhanced]
var description_replacements: Dictionary[String, ReplacementData] = {
	"CD": ReplacementData.new(),
	"ARG1": ReplacementData.new(),
	"ARG1P": ReplacementData.new(),
	"ARG2": ReplacementData.new(),
	"ARG2P": ReplacementData.new(),
	"ARG3": ReplacementData.new(),
	"ARG3P": ReplacementData.new(),
	"ARG4": ReplacementData.new(),
	"ARG4P": ReplacementData.new(),	
}

var extra_replacements: Dictionary[String, ReplacementData] = {
	"CD": ReplacementData.new(),
	"ARG1": ReplacementData.new(),
	"ARG1P": ReplacementData.new(),
	"ARG2": ReplacementData.new(),
	"ARG2P": ReplacementData.new(),
	"ARG3": ReplacementData.new(),
	"ARG3P": ReplacementData.new(),
	"ARG4": ReplacementData.new(),
	"ARG4P": ReplacementData.new(),	
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
	for r_name in description_replacements.keys():
		var a: ReplacementData = description_replacements[r_name]
		#only take into account the ones that the augment use
		if a.variable != null:
			
			if AugmentEnhanceManager.is_enhancing():
				d = TextUtils.replace_augment_string_enhancing(r_name,a.variable, a.enhanced_variable, d, self,ENHANCE_COLOR)
			else:
				#if enhanced, we paint the number
				if a.enhanced:
					d = TextUtils.replace_augment_string(r_name, a.enhanced_variable, d, self,ENHANCE_COLOR)
				else:
					d = TextUtils.replace_augment_string(r_name, a.variable, d, self)
		
	return d

func get_extra() -> String:
	var e: String = extra 
	for r_name in extra_replacements:
		var a: ReplacementData = extra_replacements[r_name]
		
		#only take into account the ones that the augment use
		if a.variable != null:
			#if enhanced, we paint the number
			if a.enhanced:
				e = TextUtils.replace_augment_string(r_name, a.enhanced_variable, e, self,ENHANCE_COLOR)
			else:
				e = TextUtils.replace_augment_string(r_name, a.variable, e, self)
	
	return e
