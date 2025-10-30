extends Augment
class_name Augment1

var efect_timer: Timer
@export var efect_increment: float = 5

func _ready() -> void:
	super._ready()
	GameEvents.cauldron_click.connect(_on_cauldron_click)
	_setup_timer()
	upgrade_efect()
	
	
func _setup_timer():
	efect_timer = Timer.new()
	
	efect_timer.wait_time = augment_res.tick_rate
	efect_timer.autostart = true
	efect_timer.one_shot = false
	efect_timer.timeout.connect(_on_timer_timeout)
	add_child(efect_timer)
	
	#print_debug("timer upgrade 1 start")
	
func _on_timer_timeout() -> void:
	upgrade_efect()


func upgrade_efect() -> void:
	Stats.add_percent_modifier(augment_res.name,efect_increment, augment_res.tick_duration, Stats.MODIFIER_TYPE.MPS)


func _on_cauldron_click() -> void:
	efect_timer.start()
	
	
