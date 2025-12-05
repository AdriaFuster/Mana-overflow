extends Node


var spawn_ranges: Array[float]
var _current_range: int = 0


func _ready() -> void:
	GameTick.tick.connect(_on_tick)
	#spawn_ranges.append(100)
	#spawn_ranges.append(150)
	
	for i in range(1, 10):
		var new_range: float = i*1000
		spawn_ranges.append(new_range)
	

func _on_tick() -> void:
	if _current_range < spawn_ranges.size():
		
		if  Comp.greater_equal(Stats.mana_spent, spawn_ranges[_current_range]) :
			#print("hem arribat a ", spawn_ranges[_current_range], 
			#" i per tant spawneem el boss d'aquest tier")
			GameEvents.change_scene.emit(GlobalEnum.GAME_SCENE.BOSS)
			_current_range += 1

func get_spawn_range() -> float:
	return spawn_ranges[_current_range]
	
	
	
