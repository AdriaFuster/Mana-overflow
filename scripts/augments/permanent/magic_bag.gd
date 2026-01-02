extends PermanentAugment
class_name MagicBag

@export var extra_space: int
@export var enhanced_extra_space: int
var _current_extra_space: int

func setup() -> void:
	_current_extra_space = extra_space
	super.setup()

func on_equip() -> void:
	Inventory.increase_max_augments(extra_space)
	super.on_equip()

func on_unequip() -> void:
	Inventory.increase_max_augments(-extra_space)

func setup_description() -> void:
	description_replacements["ARG1"].variable = "extra_space"
	description_replacements["ARG1"].enhanced_variable = "enhanced_extra_space"


func enhance() -> void:
	enhanced = true
	Inventory.increase_max_augments(-_current_extra_space)
	_current_extra_space = enhanced_extra_space
	Inventory.increase_max_augments(_current_extra_space)
	GameEvents.inventory_changed.emit()
	description_replacements["ARG1"].enhanced = true
	super.enhance()	
	
