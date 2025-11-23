extends Control

@onready var mana_label: Label = %Mana
@onready var mps_label: Label = %MPS
@onready var cauldron_power: Label = %CauldronPower


func _ready() -> void:
	GameEvents.show_boss.connect(_on_show_boss)	
	_display_values()
	

func _process(_delta: float) -> void:
	_display_values()
	

func _display_values():
	mana_label.text = "Mana = " + Stats.mana.toAmericanName()
	mps_label.text = "MPS = " + Stats.mod_mps.toAmericanName()
	cauldron_power.text = "CP = " + str(Stats.mod_cauldron_power)


func _on_show_boss() -> void:
	hide()
