extends PermanentAugment
class_name DiscountTicket

@export var cost_decrement: float
@export var enhanced_cost_decrement: float

func on_equip() -> void:
	Inventory.add_upgrade_discount(name, -cost_decrement)
	super.on_equip()

func on_unequip() -> void:
	Inventory.remove_upgrade_discount(name)

func setup_description() -> void:
	description_replacements["ARG1P"][0] = "cost_decrement"

func enhance() -> void:
	enhanced = true
	cost_decrement = enhanced_cost_decrement
	description_replacements["ARG1P"][1] = true
	Inventory.add_upgrade_discount(name, -cost_decrement)
	super.enhance()	
	
