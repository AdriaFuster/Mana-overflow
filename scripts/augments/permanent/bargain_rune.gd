extends PermanentAugment
class_name BargainRune

@export var cost_reduction: float
@export var chance: float
@export var enhanced_chance: float

var lucky_times: int = 0

func on_equip() -> void:
	GameEvents.upgrade_bought.connect(_on_upgrade_bought)
	super.on_equip()

func setup_description() -> void:
	description_replacements["ARG1P"][0] = "chance"
	description_replacements["ARG2P"][0] = "cost_reduction"

func setup_extra() -> void:
	extra_replacements["ARG1"][0] = "lucky_times"

func enhance() -> void:
	enhanced = true
	chance = enhanced_chance
	description_replacements["ARG1P"][1] = true
	super.enhance()	
	
func _on_upgrade_bought(u: Upgrade) -> void:
	var rand: float = randf()
	if rand <= chance:
		lucky_times += 1
		GameEvents.add_mana.emit(u.cost*cost_reduction)
		
