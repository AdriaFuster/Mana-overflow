extends Node
class_name GameTimer

@export var tick_interval: float = 1.0/20

var _timer: Timer
signal tick

func _ready():
	_timer = Timer.new()
	_timer.timeout.connect(_on_timeout)
	
	_timer.process_callback =Timer.TIMER_PROCESS_PHYSICS
	_timer.wait_time = tick_interval
	_timer.one_shot = false
	_timer.autostart = true
	
	add_child(_timer)

func resume() -> void:
	_timer.start()

func stop() -> void:
	_timer.stop()

func change_tick_rate(new_tick: float):
	tick_interval = new_tick
	_timer.wait_time = tick_interval
	
func _on_timeout():
	tick.emit()
	

	
