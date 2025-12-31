extends PermanentAugment
class_name MagicBag

@export var extra_space: int
@export var enhanced_extra_space: int


func on_equip() -> void:
	Inventory.increase_max_augments(extra_space)
	super.on_equip()

func on_unequip() -> void:
	Inventory.increase_max_augments(-extra_space)

func setup_description() -> void:
	description_replacements["ARG1"][0] = "extra_space"


func enhance() -> void:
	enhanced = true
	Inventory.increase_max_augments(-extra_space)
	extra_space = enhanced_extra_space
	Inventory.increase_max_augments(extra_space)
	GameEvents.inventory_changed.emit()
	description_replacements["ARG1"][1] = true
	super.enhance()	
	
