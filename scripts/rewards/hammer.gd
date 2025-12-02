extends Reward
class_name Hammer


func reward_effect() -> void:	
	AugmentEnhanceManager.enhance_augment()
	await GameEvents.augment_enhanced
	GameEvents.reward_selected.emit()
