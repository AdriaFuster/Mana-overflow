extends Control

@onready var mana_label: Label = %Mana
@onready var mps_label: Label = %MPS


func _ready() -> void:
	GameEvents.add_mana.connect(_on_add_mana)
	GameEvents.add_mps.connect(_on_add_mps)
	GameEvents.deduce_mana.connect(_on_deduced_mana)
	
	GameTick.tick.connect(_on_tick)	

func _process(delta: float) -> void:
	Stats.mana += Stats.mps * delta
	

func _display_values():
	var mana_d: String = str(Stats.mana).substr(0, 5)
	
	mana_label.text = "Mana = " + str(int(mana_d))
	mps_label.text = "MPS = " + str(int(Stats.mps))

func _on_tick():
	_display_values()	
	
	
func _on_add_mana(mana_add: float):
	Stats.mana += mana_add

func _on_add_mps(mps_add: float):
	Stats.mps += mps_add
	
func _on_deduced_mana(mana_deduced: float):
	Stats.mana -= mana_deduced
	
	
	
