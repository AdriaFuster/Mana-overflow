extends Button
class_name ShopItem

@onready var augment_icon: TextureRect = %Augment
var augment: Augment

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)


func setup(a: Augment) -> void:
	augment = a
	augment_icon.texture = augment.icon


func _on_mouse_entered() -> void:
	AugmentPopup.item_popup(Rect2i(Vector2i(global_position), Vector2i(size)), 
	augment, AugmentPopup.DISTRIBUTION_MODE.HORIZONTAL)
	

func _on_mouse_exited() -> void:
	AugmentPopup.hide_item_popup()


func _on_pressed() -> void:
	GameEvents.augment_bought.emit(augment)
