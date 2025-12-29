extends TextureButton
class_name ShopItem

@onready var augment_icon: TextureRect = %Augment
var augment: Augment

func _ready() -> void:
	pressed.connect(_on_pressed)


func setup(a: Augment) -> void:
	augment = a
	augment_icon.texture = augment.icon

func get_item() -> Variant:
	return augment

func _on_pressed() -> void:
	GameEvents.augment_bought.emit(augment)
