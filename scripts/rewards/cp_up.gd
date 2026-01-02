extends Reward
class_name CPUp


func reward_effect() -> void:
	#Multiply by 2 current cp	
	Stats.add_cp(Stats.cp)
	super.reward_effect()
