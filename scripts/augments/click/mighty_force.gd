extends ClickAugment
class_name MightyForce

@export var increment: float
@export var enhanced_increment: float
@export var enhanced_cd: float
var _current_increment: float

func setup() -> void:
	_current_increment = increment
	current_cd = cd
	super.setup()

func setup_description() -> void:
	description_replacements["CD"].variable = "cd"
	description_replacements["CD"].enhanced_variable = "enhanced_cd"
	description_replacements["ARG1P"].variable = "increment"
	description_replacements["ARG1P"].enhanced_variable = "enhanced_increment"

func _calculate_value() -> float:
	var b_mps = Stats.mod_cp
	b_mps *= _current_increment
	
	return b_mps

func augment_efect() -> void:
	
	var value: float = _calculate_value()
	
	Stats.add_mana(value)
	
	cd_cont = int(current_cd)

func enhance() -> void:
	
	enhanced = true
	current_cd = enhanced_cd
	_current_increment = enhanced_increment
	description_replacements["CD"].enhanced = true
	description_replacements["ARG1P"].enhanced = true
	super.enhance()
