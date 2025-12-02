extends Button

class_name RewardItem

@onready var reward_icon: TextureRect = %Reward

var reward: Reward

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)


func setup(r: Reward) -> void:
	reward = r
	reward_icon.texture = reward.icon


func _on_mouse_entered() -> void:
	PopupManager.show_popup(GlobalEnum.POPUP_TYPE.REWARD,
	Rect2i(Vector2i(global_position), Vector2i(size)), 
	reward, 
	GlobalEnum.DISTRIBUTION_MODE.HORIZONTAL)
	

func _on_mouse_exited() -> void:
	PopupManager.hide_popup()


func _on_pressed() -> void:
	reward.reward_effect()
	
