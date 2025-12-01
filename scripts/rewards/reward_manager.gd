extends Node

var rewards: Dictionary = {}
var n_rewards: int = 3

func generate_rewards() -> void:
	rewards.clear()
	
	var all_rewards: Dictionary = ResourceManager.rewards
	
	var rewards_array: Array = all_rewards.keys()
	rewards_array.shuffle()
	
	var array_selected_rewards: Array = rewards_array.slice(0, n_rewards)
	
	for r in array_selected_rewards:
		rewards[r] = all_rewards[r]
	

	
	
	
