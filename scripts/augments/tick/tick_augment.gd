extends Augment
class_name TickAugment

var _active: bool = false
@export var cd: float
@export var duration: float = 0.1

func on_equip() -> void:
	super.on_equip()
	cd_cont = int(cd / GameTick.tick_interval)
	
func tick() -> void:	
	if !_active:
		cd_cont -= 1
		#print ("augment ", name, " cd = ",cd_cont)

		if cd_cont <= 0:
			_augment_efect()
	else:
		active_cont -= 1
		#print ("augment ", name, " duration cd = ",active_cont)
		if  active_cont <= 0 :
			_enter_cd()
				

func _augment_efect() -> void:
	_active = true
	cd_cont = int(cd / GameTick.tick_interval)
	active_cont	= int(duration / GameTick.tick_interval)
	
	if (active_cont == 0):
		_enter_cd()

	
	var value: Big = Big.new(_calculate_value())
	#print ("value = ",value.toAmericanName())
	Stats.add_tick_modifier(name,value,Stats.MODIFIER_TYPE.MPS)

func _enter_cd() -> void:
	_active = false
	

func reset() -> void:
	super.reset()
	_active = false
	
