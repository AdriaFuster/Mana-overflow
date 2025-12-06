extends Button

class_name RewardItem

@onready var reward_icon: TextureRect = %Reward

var reward: Reward

func _ready() -> void:
	pressed.connect(_on_pressed)


func setup(r: Reward) -> void:
	reward = r
	reward_icon.texture = reward.icon


func get_item() -> Variant:
	return reward

func _on_pressed() -> void:
	reward.reward_effect()
	
