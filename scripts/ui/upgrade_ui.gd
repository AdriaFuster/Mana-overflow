extends Control
class_name UpgradeUI

@onready var button: TextureButton = %TextureButton
@onready var cost: Label = %Cost
@onready var icon: TextureRect = %Icon
@onready var amount: Label = %Amount
var upgrade: Upgrade


func _ready() -> void:
	button.pressed.connect(_on_pressed)


func setup(u:Upgrade) -> void:
	icon.texture = u.icon
	cost.text = str(u.cost)
	upgrade = u
	amount.text = str("Amount:",0)
	
	u.update_cost.connect(_on_update_cost)
	u.update_amount.connect(_on_update_amount)


func _process(_delta: float) -> void:
	if Stats.mana.isGreaterThanOrEqualTo(upgrade.cost):
		_set_state(true)
	else:
		_set_state(false)

func _set_state(active: bool) -> void:
	if active:
		button.disabled = false
		button.modulate.a = 1
	else:
		button.disabled = true
		button.modulate.a = 0.5

func _on_pressed() -> void:
	upgrade.upgrade_click()


func _on_update_cost(new_cost: int) -> void:
	cost.text = str(new_cost)
	
func _on_update_amount(new_amount: int) -> void:
	amount.text = str("Amount:",new_amount)
	
	
	
	
