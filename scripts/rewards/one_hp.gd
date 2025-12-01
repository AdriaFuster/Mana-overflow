extends Reward
class_name OneHP


func reward_effect() -> void:	
	Stats.add_hp(1)
	super.reward_effect()
