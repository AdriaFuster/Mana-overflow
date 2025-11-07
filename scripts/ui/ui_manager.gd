extends Control

@onready var mana_label: Label = %Mana
@onready var mps_label: Label = %MPS


func _ready() -> void:	
	_display_values()
	

func _process(_delta: float) -> void:
	_display_values()
	

func _display_values():
	mana_label.text = "Mana = " + Stats.mana.toAmericanName()
	mps_label.text = "MPS = " + Stats.mps.toAmericanName()
