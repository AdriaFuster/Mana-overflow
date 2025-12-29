extends PermanentAugment
class_name SleepingPillow

@export var increment: float
@export var enhanced_increment: float
var _total_increment: float = 0

@export var max_seconds: int
var _seconds: int
var _ui_seconds: int

func on_equip() -> void:
	super.on_equip()
	GameEvents.cauldron_click.connect(_on_cauldron_click)
	
	_seconds = 0
	
func setup_description() -> void:
	description_replacements["ARG1P"][0] = "increment"
	description_replacements["ARG1"][0] = "max_seconds"

func setup_extra() -> void:
	extra_replacements["ARG1P"][0] = "_total_increment"
	extra_replacements["ARG1"][0] = "_ui_seconds"

func _calculate_value() -> float:
	return _total_increment*Stats.mod_cauldron_power

func apply_effect() -> void:
	var cps_value: float = _calculate_value()
	set_tick_mps_increment(0)
	Stats.mod_cauldron_power += cps_value
		
func _increment_cp_mod() -> void:
	_total_increment += increment
	GameEvents.update_augment_info.emit(self)

func tick() -> void:
	
	if _seconds < max_seconds/GameTick.tick_interval:
		_seconds += 1
		_ui_seconds = int(_seconds * GameTick.tick_interval)
		#1 second
		if fmod(_seconds, 10) == 0:
			_increment_cp_mod()

func enhance() -> void:
	enhanced = true
	increment = enhanced_increment
	description_replacements["ARG1P"][1] = true
	super.enhance()	


func _on_cauldron_click() -> void:
	_seconds = 0
	_total_increment = 0
