extends TickAugment
class_name GrowingLeaf

@export var increment: float
@export var enhanced_increment: float
var _current_increment: float

@export var enhanced_cd: int

func setup() -> void:
	_current_increment = increment
	super.setup()

func on_equip() -> void:
	GameEvents.cauldron_click.connect(_on_cauldron_click)
	super.on_equip()
	
func setup_description() -> void:
	description_replacements["ARG1P"].variable = "increment"
	description_replacements["ARG1P"].enhanced_variable = "enhanced_increment"
	description_replacements["CD"].variable = "cd"
	description_replacements["CD"].enhanced_variable = "enhanced_cd"
	
func _calculate_value() -> float:
	var b_mps = Stats.mod_mps
	b_mps *= _current_increment+1
	
	return b_mps


func _on_cauldron_click() -> void:
	cd_cont = int(_current_cd / GameTick.tick_interval)
	_active = false
	

func enhance() -> void:
	enhanced = true
	_current_increment = enhanced_increment
	_current_cd = enhanced_cd
	description_replacements["ARG1P"].enhanced = true
	description_replacements["CD"].enhanced = true
	super.enhance()
