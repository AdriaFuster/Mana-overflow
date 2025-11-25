extends Control
class_name BossScene

@onready var canvas_layer: CanvasLayer = %CanvasLayer
@onready var start_timer_label: RichTextLabel = %StartTimerCounter
@onready var fight_timer_label: RichTextLabel = %FightTimerCounter
@onready var text_announces_label: RichTextLabel = %TextAnnounces
@onready var start_button: Button = %StartButton

@onready var big_cauldron: Cauldron = %BigCauldron
@onready var timer: Timer = %Timer

@onready var boss: Boss = %Boss

var _number_hits: int = 10

var _start_countdown: int = 3
var _fight_countdown: int = 2

var _timer_counter: int

enum STATE{
	IDLE,
	COUNTDOWN,
	FIGHT,
	HURT_BOSS
}

var scene_state: STATE = STATE.IDLE


func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	boss.dead.connect(_on_boss_dead)


func activate_scene() -> void:
	show()
	canvas_layer.show()
	
	_setup_countdown()
	boss._setup()	


func desactivate_scene() -> void:
	hide()
	canvas_layer.hide()
	

func _setup_countdown() -> void:
	scene_state = STATE.COUNTDOWN
	big_cauldron.show_cauldron(false)
	
	_show_start_button(true)
	await start_button.pressed
	_show_start_button(false)
	
	_setup_timer_counter_label()
	
	_setup_countdow_timer()
	
	
func _setup_countdow_timer() -> void:
	_timer_counter = _start_countdown
	_update_timer_counter(_timer_counter)
	
	timer.one_shot = false
	timer.wait_time = 1
	timer.start()

func _setup_fight() -> void:
	scene_state = STATE.FIGHT
	big_cauldron.disable_button(false)
	big_cauldron.show_cauldron(true)
	_setup_timer_counter_label()
	
	_setup_fight_timer()

func _setup_fight_timer() -> void:
	_timer_counter = _fight_countdown
	_update_timer_counter(_timer_counter)
	
	timer.one_shot = false
	timer.wait_time = 1
	timer.start()

func _setup_hurt_boss() -> void:
	scene_state = STATE.HURT_BOSS
	big_cauldron.disable_button(true)
	_apply_damage()

func _apply_damage() -> void:
	await boss.take_damage(Stats.mana)
	
	if boss.is_alive:
		pass
		await _set_annouce_text("You loose 1 hp", 3)
		GameEvents.change_scene.emit(GlobalEnum.GAME_SCENE.CLICK)
	
	else:
		#exit boss scene
		await _set_annouce_text("You defeated the boss", 3)
		GameEvents.change_scene.emit(GlobalEnum.GAME_SCENE.CLICK)
		

func _setup_timer_counter_label() -> void:

	if scene_state == STATE.COUNTDOWN:
		start_timer_label.text = ""
		start_timer_label.show()
		fight_timer_label.hide()
	elif  scene_state == STATE.FIGHT:
		fight_timer_label.text = ""
		start_timer_label.hide()
		fight_timer_label.show()


func _update_timer_counter(l_text: int) -> void:
	if scene_state == STATE.COUNTDOWN:
		start_timer_label.text = str(l_text)
	elif scene_state == STATE.FIGHT:
		fight_timer_label.text = str(l_text)
	
func _set_annouce_text(a_text: String, text_duration: float) -> void:
	text_announces_label.show()
	text_announces_label.text = a_text
	await get_tree().create_timer(text_duration).timeout
	text_announces_label.hide()
	
	
func _on_timer_timeout() -> void:
	_timer_counter -= 1
	_update_timer_counter(_timer_counter)
	if _timer_counter == 0: 
		timer.stop()
		if scene_state == STATE.COUNTDOWN:
			_setup_fight()
			_set_annouce_text("Start", 1)
			
		elif  scene_state == STATE.FIGHT:
			_set_annouce_text("Time's Up!", 1)
			_setup_hurt_boss()
			
func _on_boss_dead() -> void:
	pass


func _show_start_button(b_show: bool) -> void:
	start_button.visible = b_show
	
