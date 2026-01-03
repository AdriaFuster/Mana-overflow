extends Node
var spawn_ranges: Array[BossRange]
var index_range: int = 0

class BossRange:
	var spawn_range: float
	var hp: float
	
	func _init(p_spawn_range: float, p_hp: float ) -> void:
		spawn_range = p_spawn_range
		hp = p_hp
		
		
func _ready() -> void:
	GameTick.tick.connect(_on_tick)
	spawn_ranges.append(BossRange.new(3500, 300))
	spawn_ranges.append(BossRange.new(7000, 1000))
	
	#for i in range(1, 10):
		#var new_range: float = i*1000
		#spawn_ranges.append(new_range)
	

func _on_tick() -> void:
	if index_range < spawn_ranges.size():
		
		if  Comp.greater_equal(Stats.mana_spent, spawn_ranges[index_range].spawn_range) :
			#print("hem arribat a ", spawn_ranges[_current_range], 
			#" i per tant spawneem el boss d'aquest tier")
			GameEvents.change_scene.emit(GlobalEnum.GAME_SCENE.BOSS)
			index_range += 1

func get_current_spawn_range() -> float:
	return spawn_ranges[index_range].spawn_range

func get_current_boss_hp() -> float:
	return spawn_ranges[index_range].hp
	
func get_index_range() -> float:
	return index_range
	

	
	
	
