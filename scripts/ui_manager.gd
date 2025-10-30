extends Control

@onready var mana_label: Label = %Mana
@onready var mps_label: Label = %MPS

var _ui_timer: Timer
@export var _ui_timer_tick_rate: float = 1/20


func _ready() -> void:	
	_display_values()
	
	_ui_timer = Timer.new()
	_ui_timer.autostart = true
	_ui_timer.wait_time = _ui_timer_tick_rate
	_ui_timer.timeout.connect(_on__ui_timer_timeout)
	add_child(_ui_timer)
	
	_ui_timer.start()
	

func _process(delta: float) -> void:
	_display_values()
	

func _display_values():
	mana_label.text = "Mana = " + Stats.mana.toAmericanName(true)
	mps_label.text = "MPS = " + Stats.mps.toAmericanName()


func _on__ui_timer_timeout():
	var random_offset: float = randf_range(0.01, 0.015) 
	var new_tick_rate = _ui_timer_tick_rate+random_offset
	_ui_timer.wait_time = new_tick_rate	
