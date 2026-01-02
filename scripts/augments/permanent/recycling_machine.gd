extends PermanentAugment
class_name RecyclingMachine

@export var increment: float
@export var enhanced_increment: float
var total_increment: float = 0
var _current_increment: float

@export var mana_to_spend: float

const MULTIPLIER_RATE: float = 1.5
var mana_spended: float = 0

func setup() -> void:
	_current_increment = increment	
	super.setup()

func on_equip() -> void:
	GameEvents.upgrade_bought.connect(_on_upgrade_bought)
	super.on_equip()

func setup_description() -> void:
	description_replacements["ARG1"].variable = "mana_to_spend"
	description_replacements["ARG1P"].variable = "increment"
	description_replacements["ARG1P"].enhanced_variable = "enhanced_increment"

func setup_extra() -> void:
	extra_replacements["ARG1P"].variable = "total_increment"
	
	
func _calculate_value() -> float:
	var b_mps = Stats.mod_mps
	b_mps *= total_increment
	
	return b_mps

func apply_effect() -> void:
	var add_mps_value: float = _calculate_value()
	set_tick_mps_increment(add_mps_value)
	Stats.mod_mps += add_mps_value

func enhance() -> void:
	enhanced = true
	_current_increment = enhanced_increment
	description_replacements["ARG1P"].enhanced = true
	super.enhance()	

func increment_mana_to_spend() -> void:
	mana_to_spend *= MULTIPLIER_RATE
	
func _on_upgrade_bought(u: Upgrade) -> void:
	mana_spended += u.cost 
	while true:
		if mana_spended >= mana_to_spend:
			total_increment += _current_increment
			mana_spended -= mana_to_spend
			increment_mana_to_spend()
		else:
			break
		
