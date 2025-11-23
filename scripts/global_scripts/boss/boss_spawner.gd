extends Node


var spawn_ranges: Array[Big]
var _current_range: int = 0


func _ready() -> void:
	for i in range(1, 10):
		var new_rangee: Big = Big.new(i*100)
		spawn_ranges.append(new_rangee)
	

func _process(_delta: float) -> void:
	if  Stats.mana.isGreaterThanOrEqualTo(spawn_ranges[_current_range]):
		print("hem arribat a ", spawn_ranges[_current_range].toAmericanName(), 
		" i per tant spawneem el boss d'aquest tier")
		GameEvents.change_scene.emit(GlobalEnum.GAME_SCENE.BOSS)
		if _current_range < spawn_ranges.size():
			_current_range += 1
		else:
			print("ja hem fet spanw de tots els bossees")
		
