extends Node2D
class_name Upgrade

@export var upgrade_name: String
@export var cost: int = 10
@export var mps_upgrade: int = 1
@onready var upgrade: UpgradeAnimations = %TextureButton
@onready var cost_label: Label = %CostLabel
@onready var amount_label: Label = %AmountLabel


func _ready() -> void:
	upgrade.pressed.connect(_on_pressed)
	_setup()
	

func _process(_delta: float) -> void:
	if (Stats.mana < cost):
		upgrade.disabled = true
		upgrade.modulate.a = .6
	else: 
		upgrade.disabled = false
		upgrade.modulate.a = 1


func _setup():
	cost_label.text = str(cost)
	_update_upgrade_amount()
	
func _update_upgrade_amount() ->void :
	amount_label.text = "Amount:"+ str(Stats.get_upgrade_amount(upgrade_name))

func _on_pressed():
	pass
