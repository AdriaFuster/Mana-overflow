extends Resource
class_name Upgrade


@export var name: String = "upgrade"
@export var description: String
@export var cost: float = 10
@export var mps: float = 1
@export var tick_rate: float = 0.4
@export var amount: int = 0
@export var icon: Texture2D

const MULTIPLIER_RATE: float = 1.15

signal update_cost(new_cost: int)
signal update_amount(new_amount: int)
	
func _increase_cost() -> void:
	cost *= MULTIPLIER_RATE
	update_cost.emit(cost)
	
func _increase_amount() -> void:
	amount += 1
	update_amount.emit(amount)

func upgrade_click() -> void:
	_increase_amount()
	
	GameEvents.deduce_mana.emit(cost)
	_increase_cost()
	
	GameEvents.calculate_mps.emit()
	
	
