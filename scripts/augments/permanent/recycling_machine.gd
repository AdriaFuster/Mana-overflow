extends PermanentAugment
class_name RecyclingMachine

@export var increment: float
@export var enhanced_increment: float
var total_increment: float = 0
@export var mana_to_spend: float

const MULTIPLIER_RATE: float = 1.5
var mana_spended: float = 0

func on_equip() -> void:
	GameEvents.upgrade_bought.connect(_on_upgrade_bought)
	super.on_equip()

func setup_description() -> void:
	description_replacements["ARG1"][0] = "mana_to_spend"
	description_replacements["ARG1P"][0] = "increment"

func setup_extra() -> void:
	extra_replacements["ARG1P"][0] = "total_increment"
	
	
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
	increment = enhanced_increment
	description_replacements["ARG1P"][1] = true
	super.enhance()	

func increment_mana_to_spend() -> void:
	mana_to_spend *= MULTIPLIER_RATE
	
func _on_upgrade_bought(u: Upgrade) -> void:
	mana_spended += u.cost 
	print("mana_spended = ", mana_spended)
	while true:
		if mana_spended >= mana_to_spend:
			print("mana_spended = ")
			total_increment += increment
			print("pujem l'increment = ", total_increment)
			mana_spended -= mana_to_spend
			#increment_mana_to_spend()
		else:
			break
		
