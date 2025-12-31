extends PermanentAugment
class_name OldHourglass

@export var increment: float
@export var enhanced_increment: float
var _real_increment: float = 0

@export var cd: int
var _seconds: int
var _ui_seconds: int

var _active :bool = false

var _unchanged_mps: float


func on_equip() -> void:
	super.on_equip()
	
	_unchanged_mps = Stats.final_mps
	_seconds = int(cd/GameTick.tick_interval)
	set_ui_seconds()
func setup_description() -> void:
	description_replacements["ARG1P"][0] = "increment"
	description_replacements["CD"][0] = "cd"

func setup_extra() -> void:
	extra_replacements["ARG1P"][0] = "_real_increment"
	extra_replacements["ARG1"][0] = "_ui_seconds"

func _calculate_value() -> float:
	return _real_increment*Stats.mod_mps

func apply_effect() -> void:
	var mps_value: float = _calculate_value()
	set_tick_mps_increment(mps_value)
	Stats.mod_mps += mps_value
		
func _activate_increment(a: bool) -> void:
	_active = a
	
	if a :
		_real_increment = increment
		_seconds = 0
	else:
		_seconds = int(cd/GameTick.tick_interval)
		_real_increment = 0
	
	set_ui_seconds()


func tick() -> void:
	print("--------------")
	print("_unchanged_mps ", _unchanged_mps)
	print("Stats.final_mps ", Stats.final_mps)
	
	if _unchanged_mps == Stats.final_mps - tick_mps_increment:
		
		if !_active:
				_seconds -= 1
				print("_seconds ", _seconds)
				if fmod(_seconds, 10) == 0:
					set_ui_seconds()
				if _seconds == 0:
					_activate_increment(true)
			
	else:
		print("ha canviat els mps, fem reset del cd")
		_activate_increment(false)
		_unchanged_mps = Stats.final_mps
	
	GameEvents.update_augment_info.emit(self)	
func enhance() -> void:
	enhanced = true
	increment = enhanced_increment
	description_replacements["ARG1P"][1] = true
	super.enhance()	

func set_ui_seconds() -> void:
	_ui_seconds = int(_seconds * GameTick.tick_interval)
