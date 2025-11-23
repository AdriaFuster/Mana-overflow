extends Node

@export var tick_interval: float = 0.1

var _timer: Timer
signal tick
var _n_tick: int = 0

func _ready():
	_timer = Timer.new()
	_timer.timeout.connect(_on_timeout)
	GameEvents.change_scene.connect(_on_change_scene)
	
	_timer.process_callback =Timer.TIMER_PROCESS_PHYSICS
	_timer.wait_time = tick_interval
	_timer.one_shot = false
	_timer.autostart = true
	
	add_child(_timer)
	
	_tick()

func resume() -> void:
	_timer.start()

func stop() -> void:
	_timer.stop()

func change_tick_rate(new_tick: float):
	tick_interval = new_tick
	_timer.wait_time = tick_interval
	
func _on_timeout():
	_tick()

func _tick() -> void:
	#if _n_tick%10 == 0:
		#print(_n_tick)
	_n_tick += 1
	tick.emit()	

func _on_change_scene(scene: GlobalEnum.GAME_SCENE) -> void:
	if scene == GlobalEnum.GAME_SCENE.BOSS:
		stop()
		await get_tree().create_timer(5).timeout
		resume()
	elif scene == GlobalEnum.GAME_SCENE.CLICK:
		resume()
		
	
