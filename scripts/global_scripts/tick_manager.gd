extends Node


var _listeners: Array = []

func _ready() -> void:
	GameTick.tick.connect(_on_tick)
	

func register(obj, priority: int) -> void:
	_listeners.append({
	"obj": obj, 
	"priority": priority 
	})
		
	_listeners.sort_custom(_sort_by_priority)

func unregister(obj) -> void:
	_listeners = _listeners.filter(func(e):
		return e.obj != obj
	)
	
func _sort_by_priority(a, b) -> bool:
	return a.priority < b.priority
	
	
func _on_tick() -> void:
	GameManager.reset_mod_values()
	
	GameManager.calculate_cauldron_modifiers()
	
	Inventory._on_tick_permanent_a()
	
	#Calculem MPS amb modifiers permanents
	GameManager.calculate_permanent_modifiers()
	
	
	Inventory._on_tick_tick_a()
	#Augments i upgrades
	#for entry in _listeners:
		#var o = entry.obj
		#if o and o.has_method("_on_tick"):
			#o._on_tick()
	
	
		
	#MPS + tick modifiers
	GameManager.calculate_tick_modifiers()
		
		
