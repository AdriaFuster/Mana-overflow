extends ClickAugment
class_name LuckyCoin

@export var increment: float
var luck_rate: float = 0.5
var succes_flip: bool = false

func setup_description() -> void:
	d_replacements["ARG1P"][0] = "increment"

func _calculate_value() -> float:
	var value: float = 0
	var mod_cp = Stats.mod_cauldron_power
	var coin_flip: float = randf()
	succes_flip = coin_flip < luck_rate
	if succes_flip:
		value = mod_cp*increment
	return value

func augment_efect() -> float:
	var value: float = _calculate_value()
	
	Stats.add_mana(value)
	
	cd_cont = int(cd)
	return value

func enhance() -> void:
	enhanced = true
	increment = 0.4
	d_replacements["ARG1P"][1] = true
	super.enhance()
	
func is_activated() -> bool:
	return succes_flip
