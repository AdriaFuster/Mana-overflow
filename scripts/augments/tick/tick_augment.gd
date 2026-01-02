extends Augment
class_name TickAugment

var _active: bool = false
var cd_cont: int
var active_cont: float

@export var cd: int
@export var duration: int

var _current_cd: float

func on_equip() -> void:
	_current_cd = cd
	cd_cont = int(_current_cd / GameTick.tick_interval)
	super.on_equip()
	
func reset() -> void:
	super.reset()
	cd_cont = int(_current_cd / GameTick.tick_interval)
	_active = false

func is_active() -> bool:
	return _active

	
func tick() -> void:	
	
	if !_active:
		cd_cont -= 1
		#print ("augment ", name, " cd = ",cd_cont)

		if cd_cont <= 0:
			_set_active()
	else:
		active_cont -= 1
		#print ("augment ", name, " duration cd = ",active_cont)
		#print ("augment ", name, " cd = ",cd_cont)
		if  active_cont <= 0 :
			_enter_cd()
				

func _set_active() -> void:
	_active = true
	
	if duration == 0:
		active_cont = GameTick.tick_interval
	else:
		active_cont	= int(duration/ GameTick.tick_interval)
		
	if (active_cont == 0):
		_enter_cd()

func augment_efect() -> void:
	augment_activated.emit()
	var add_mana: float = _calculate_value()
	Stats.add_mana(add_mana)


func _enter_cd() -> void:
	_active = false
	cd_cont = int(_current_cd / GameTick.tick_interval)

	
	
