extends InventoryItem
class_name Upgrade


@export var order: int
@export var base_cost: float
var cost: float:
	get:
		return get_cost()

@export var mps: float = 1
@export var amount: int = 0
var lvl: int = 1

#augment_name, discount
var discounts: Dictionary = {}

var locked_name: String = "????"
var locked_description: String = "??????"
@export var locked: bool = true

const MULTIPLIER_RATE: float = 1.15
const UNLOCK_PERCENT: float = 0.7
const MPS_INCREMENT: float = 1.5

signal update_cost(new_cost: float)
signal update_amount(new_amount: int)
	

func setup() -> void:
	if locked:
		GameTick.tick.connect(_on_tick)
	
	description = "Each $NAME$ adds $MPS$ mana per second"
	
	
func _increase_cost() -> void:
	base_cost *= MULTIPLIER_RATE
	update_cost.emit(cost)
	
func _increase_amount() -> void:
	if amount == 0:
		GameEvents.new_upgrade_bought.emit()
	amount += 1
	update_amount.emit(amount)

func _increase_lvl() -> void:
	if amount%10 == 0:
		lvl += 1
		mps = snappedf(MPS_INCREMENT*mps, 0.01)
		GameEvents.upgrade_lvl_up.emit()
	
func upgrade_click() -> void:
	_increase_amount()
	_increase_lvl()
	
	GameEvents.deduce_mana.emit(cost)
	GameEvents.upgrade_bought.emit(self)
	Stats.spend_mana(cost)
	
	_increase_cost()
	
	GameEvents.update_upgrade_info.emit(self)
	
	GameEvents.calculate_mps.emit()

func get_description() -> String:
	var d: String = description 
	d = TextUtils.replace_upgrade_string("NAME", "name", d, self)
	d = TextUtils.replace_upgrade_string("MPS", "mps", d, self, UpgradeLvl.get_lvl_color(lvl))
	
	return d

func get_lvl(prefix: String) -> String:
	var c: Color = UpgradeLvl.get_lvl_color(lvl)
	return TextUtils.set_color(prefix+str(lvl),c)
		
func get_cost() -> float:
	var final_cost = base_cost
	
	#Hauriem d'agafar els augment en l'ordre del inventory. Que Inventory tingui una funcio
	#que et retorni l'ordre dels augments, aixi tot pot funcionar igual, simplement que només hem de
	#canviar l'ordre d'execucció
	for d in discounts.keys():
		final_cost += final_cost*discounts[d]
	
	return final_cost	

func add_discount(augment_name: String, discount: float) -> void:
		discounts[augment_name] = discount
		update_cost.emit(cost)
	
func remove_discount(augment_name: String) -> void:
	if discounts.has(augment_name):
		discounts.erase(augment_name)
	
	update_cost.emit(cost)

func _on_tick() -> void:
	var upgrade_unlock_cost: float = cost * UNLOCK_PERCENT
	
	#print("Comprovem si per la upgrade", name, "podem comprarla")
	if Comp.greater_equal(Stats.mana,upgrade_unlock_cost):
		#print("SI PODEEM")
		locked = false
		GameEvents.update_upgrade_info.emit(self)
		
		if GameTick.tick.is_connected(_on_tick):
			GameTick.tick.disconnect(_on_tick)
