extends ClickAugment
class_name LuckyCoin

@export var increment: float
@export var enhanced_increment: float
var _current_increment: float

var luck_rate: float = 0.5
var succes_flip: bool = false
var lucky_times: int = 0

func setup() -> void:
	_current_increment = increment
	super.setup()

func setup_description() -> void:
	description_replacements["ARG1P"].variable = "increment"
	description_replacements["ARG1P"].enhanced_variable = "enhanced_increment"

func setup_extra() -> void:
	extra_replacements["ARG1"].variable = "lucky_times"

func _calculate_value() -> float:
	var value: float = 0
	var mod_cp = Stats.mod_cp
	var coin_flip: float = randf()
	succes_flip = coin_flip < luck_rate
	
	if succes_flip:
		lucky_times += 1
		value = mod_cp*_current_increment
		
	return value

func augment_efect() -> void:
	var value: float = _calculate_value()
	Stats.add_mana(value)

func enhance() -> void:
	enhanced = true
	_current_increment = enhanced_increment
	description_replacements["ARG1P"].enhanced = true
	super.enhance()
	
func is_activated() -> bool:
	return succes_flip
