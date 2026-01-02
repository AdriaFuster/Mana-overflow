extends PermanentAugment
class_name DiscountTicket

@export var cost_decrement: float
@export var enhanced_cost_decrement: float
var _current_cost_decrement: float


func setup() -> void:
	_current_cost_decrement = cost_decrement
	super.setup()

func on_equip() -> void:
	Inventory.add_upgrade_discount(name, -_current_cost_decrement)
	super.on_equip()

func on_unequip() -> void:
	Inventory.remove_upgrade_discount(name)

func setup_description() -> void:
	description_replacements["ARG1P"].variable = "cost_decrement"
	description_replacements["ARG1P"].enhanced_variable= "enhanced_cost_decrement"


func enhance() -> void:
	enhanced = true
	_current_cost_decrement = enhanced_cost_decrement
	description_replacements["ARG1P"].enhanced = true
	Inventory.add_upgrade_discount(name, -_current_cost_decrement)
	super.enhance()	
	
