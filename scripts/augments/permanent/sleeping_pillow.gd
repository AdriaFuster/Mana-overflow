extends PermanentAugment
class_name SleepingPillow

@export var increment: float
@export var enhanced_increment: float
var _total_increment: float = 0
var _current_increment: float

@export var max_seconds: int
var _seconds: int
var _ui_seconds: int

func setup() -> void:
	_current_increment = increment
	_seconds = 0
	super.setup()

func on_equip() -> void:
	GameEvents.cauldron_click.connect(_on_cauldron_click)
	super.on_equip()
	
	
func setup_description() -> void:
	description_replacements["ARG1P"].variable = "increment"
	description_replacements["ARG1P"].enhanced_variable = "enhanced_increment"
	description_replacements["ARG1"].variable = "max_seconds"

func setup_extra() -> void:
	extra_replacements["ARG1P"].variable = "_total_increment"
	extra_replacements["ARG1"].variable = "_ui_seconds"

func _calculate_value() -> float:
	return _total_increment*Stats.mod_cp

func apply_effect() -> void:
	var cps_value: float = _calculate_value()
	set_tick_mps_increment(0)
	Stats.mod_cp += cps_value
		
func _increment_cp_mod() -> void:
	_total_increment += _current_increment
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
	_current_increment = enhanced_increment
	description_replacements["ARG1P"].enhanced = true
	super.enhance()	


func _on_cauldron_click() -> void:
	_seconds = 0
	_total_increment = 0
