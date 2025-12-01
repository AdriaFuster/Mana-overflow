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
	#AugmentPopup.item_popup(Rect2i(Vector2i(global_position), Vector2i(size)), 
	#augment, AugmentPopup.DISTRIBUTION_MODE.HORIZONTAL)
	pass
	

func _on_mouse_exited() -> void:
	#AugmentPopup.hide_item_popup()
	pass


func _on_pressed() -> void:
	#GameEvents.augment_bought.emit(augment)
	reward.reward_effect()
	pass
