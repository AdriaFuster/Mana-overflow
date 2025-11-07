extends Augment
class_name TickAugment


@export var seconds_cd: float = 1
@export var seconds_duration: float = 1
@export var permanent: bool

var _cd_cont: float
var _active_cont: float
var _active: bool = false
		
func on_equip() -> void:
	cd = seconds_cd
	duration = seconds_duration
	_cd_cont = seconds_cd
		
	
func tick() -> void:
	if permanent:
		print("augment ", name, " es permanent")
		_permanent_augment_efect()
	else:	
		if !_active:
			_cd_cont -= GameTick.tick_interval
			print ("augment ", name, " cd = ",snapped(_cd_cont, 0.1))
			if _equal_comparision(_cd_cont, 0):
				_augment_efect()
		else:
			_active_cont -= GameTick.tick_interval
			print ("augment ", name, " duration cd = ",snapped(_active_cont, 0.1))
			if  _equal_comparision(_active_cont, 0):
				_enter_cd()
				
				
func _permanent_augment_efect() -> void:
	var value: Big = Big.new(_calculate_value())
	print ("value = ",value.toAmericanName())
	Stats.add_tick_modifier(name,value,Stats.MODIFIER_TYPE.MPS)

func _augment_efect() -> void:
	_active = true
	_active_cont = seconds_duration
	
	var value: Big = Big.new(_calculate_value())
	print ("value = ",value.toAmericanName())
	Stats.add_tick_modifier(name,value,Stats.MODIFIER_TYPE.MPS)

func _enter_cd() -> void:
	_active = false
	_cd_cont = seconds_cd
	

func _equal_comparision(n1: float, n2:float) -> bool:
	return (n1-n2) < 0.0000000001
	
