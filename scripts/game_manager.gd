extends Control

@onready var mana_label: Label = %Mana
@onready var mps_label: Label = %MPS
@onready var mps_timer: Timer = %MPSTimer


var mana :int
var mps :int

func _ready() -> void:
	mps_timer.timeout.connect(_on_timer_timeout)
	GameEvents.add_mana.connect(_on_add_mana)
	GameEvents.add_mps.connect(_on_add_mps)
	GameEvents.deduce_mana.connect(_on_deduced_mana)
	
	mps_timer.wait_time = Stats.mps_timer
	

func _process(_delta: float) -> void:
	mana_label.text = "Mana = " + str(Stats.mana)
	mps_label.text = "MPS = " + str(Stats.mps)


func _on_timer_timeout():
	GameEvents.add_mana.emit(Stats.mps)	
	
	
func _on_add_mana(mana_add: int):
	Stats.mana += mana_add

func _on_add_mps(mps_add: int):
	Stats.mps += mps_add
	
func _on_deduced_mana(mana_deduced: int):
	Stats.mana -= mana_deduced
	
	
	
