extends Node2D

@export var cost: int = 10
@export var mps_upgrade: int = 1
@onready var upgrade: UpgradeAnimations = %TextureButton


func _ready() -> void:
	upgrade.pressed.connect(_on_pressed)
		
func _process(_delta: float) -> void:
	if (Stats.mana < cost):
		upgrade.disabled = true
		upgrade.modulate.a = .8
	else: 
		upgrade.disabled = false
		upgrade.modulate.a = 1


func _on_pressed():
	GameEvents.add_mps.emit(mps_upgrade)
	GameEvents.deduce_mana.emit(cost)
