extends BaseScene
class_name BossScene

@onready var canvas_layer: CanvasLayer = %CanvasLayer
@onready var start_counter_label: RichTextLabel = %start_counter

var _start_timer: Timer
var _start_counter: int = 3


func _setup() -> void:
	_on_click_scene()


func _show_cauldron() -> void:
	pass


func _on_boss_scene() -> void:
	show()
	canvas_layer.show()
	_setup_timer()
	
	
func _on_click_scene() -> void:
	hide()
	canvas_layer.hide()

func _setup_timer() -> void:
	_start_counter = 3
	_update_start_counter(_start_counter)
	
	_start_timer = Timer.new()
	_start_timer.one_shot = false
	_start_timer.wait_time = 1
	_start_timer.timeout.connect(_on_start_timer_timeout)
	add_child(_start_timer)
	_start_timer.start()
	print("timer start")

func _update_start_counter(l_text) -> void:
	start_counter_label.text = str(l_text)

	
func _on_start_timer_timeout() -> void:
	print("timer timeout")
	_start_counter -= 1
	_update_start_counter(_start_counter)
	if _start_counter == 0: 
		_start_timer.stop()
		
		
		_update_start_counter("Start!")
		await get_tree().create_timer(1).timeout
		start_counter_label.hide()
		
	

	
	
