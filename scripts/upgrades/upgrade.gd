extends InventoryItem
class_name Upgrade


@export var order: int
@export var cost_mantissa: float
@export var cost_exponent: int
var cost: Big

@export var mps: float = 1
@export var amount: int = 0
@export var icon: Texture2D

const MULTIPLIER_RATE: float = 1.15
const UNLOCK_PERCENT: float = 0.8

signal update_cost(new_cost: Big)
signal update_amount(new_amount: int)
	

func setup() -> void:
	
	cost = Big.new(cost_mantissa, cost_exponent)
	
	if locked:
		GameTick.tick.connect(_on_tick)
	
	description = "Each $NAME$ adds $MPS$ mana per second"
	

	description = _replace_string("NAME", "name", description)
	description = _replace_string("MPS", "mps", description)
	
	
func _increase_cost() -> void:
	cost.multiplyEquals(MULTIPLIER_RATE)
	update_cost.emit(cost)
	
func _increase_amount() -> void:
	amount += 1
	update_amount.emit(amount)

func upgrade_click() -> void:
	_increase_amount()
	
	#print("upgrade ", name, " i ens gastem ", cost.toAmericanName())
	GameEvents.deduce_mana.emit(cost)
	_increase_cost()
	
	GameEvents.calculate_mps.emit()

func _on_tick() -> void:
	var upgrade_unlock_cost: Big = Big.new(cost)
	upgrade_unlock_cost.multiplyEquals(UNLOCK_PERCENT)
	
	#print("Comprovem si per la upgrade", name, "podem comprarla")
	if Stats.mana.isGreaterThanOrEqualTo(upgrade_unlock_cost):
		#print("SI PODEEM")
		locked = false
		
		if GameTick.tick.is_connected(_on_tick):
			GameTick.tick.disconnect(_on_tick)


func _replace_string(replace_string: String, var_name: String, text: String ) -> String:
	
	var dollar_replace_string = "$"+replace_string+"$"
	var new_text := text
	
	if dollar_replace_string not in text or get(var_name) == null:
		return new_text
	
	var var_value = get(var_name)
	

	new_text = text.replace(dollar_replace_string, str(var_value))
	
	return new_text
