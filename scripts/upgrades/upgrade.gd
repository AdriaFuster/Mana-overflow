extends InventoryItem
class_name Upgrade


@export var cost: float = 10
@export var mps: float = 1
@export var tick_rate: float = 0.4
@export var amount: int = 0
@export var icon: Texture2D

const MULTIPLIER_RATE: float = 1.15

signal update_cost(new_cost: int)
signal update_amount(new_amount: int)
	

func setup() -> void:
	if locked:
		GameTick.tick.connect(_on_tick)
	
	description = description.replace("$MPS$", str(mps))
	
	
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

func _on_tick() -> void:
	var upgrade_unlock_cost: float = cost * 0.8
	if Stats.mana.isGreaterThanOrEqualTo(upgrade_unlock_cost):
		locked = false
		
		if GameTick.tick.is_connected(_on_tick):
			GameTick.tick.disconnect(_on_tick)
