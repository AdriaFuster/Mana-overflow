extends Node2D
class_name Upgrade

@export var upgrade_res: UpgradeResource
@onready var upgrade: UpgradeAnimations = %TextureButton
@onready var cost_label: Label = %CostLabel
@onready var amount_label: Label = %AmountLabel
@onready var description_label: Label = %Description


const MULTIPLIER_RATE: float = 1.15

func _ready() -> void:
	upgrade.pressed.connect(_on_pressed)
	_setup()
	

func _process(_delta: float) -> void:
	if (Stats.mana.isLessThan(upgrade_res.cost)):
		upgrade.disabled = true
		upgrade.modulate.a = .6
	else: 
		upgrade.disabled = false
		upgrade.modulate.a = 1


func _setup():
	cost_label.text = str(upgrade_res.cost)
	description_label.text = str(upgrade_res.description)
	_update_amount_label()
	
func _update_amount_label() ->void :
	amount_label.text = "Amount:"+ str(Stats.get_upgrade_amount(self))

func _update_cost_label() -> void:
	cost_label.text = str(upgrade_res.cost)
	
	
func _increase_cost() -> void:
	upgrade_res.cost *= MULTIPLIER_RATE
	

func _on_pressed():
	GameEvents.deduce_mana.emit(upgrade_res.cost)
	GameEvents.calculate_mps.emit()
	
	_increase_cost()
	
	_update_amount_label()
	_update_cost_label()
