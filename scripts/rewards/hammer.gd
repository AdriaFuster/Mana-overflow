extends Reward
class_name Hammer


func reward_effect() -> void:	
	AugmentEnhanceManager.start_enhancing()
	await GameEvents.augment_enhanced
	super.reward_effect()
