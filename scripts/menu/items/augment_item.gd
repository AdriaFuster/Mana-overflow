extends Control
class_name AugmentUI

@onready var icon: TextureRect = $Button/TextureRect
@onready var button: TextureButton = $Button
@onready var cd: Label = $Cd
@onready var permanent: TextureRect = $permanent
@onready var anim_player: AnimationPlayer = %AnimationPlayer


var augment: Augment

func _ready() -> void:
	button.pressed.connect(_on_button_pressed)

func setup(a: Augment) -> void:
	augment = a
	augment.augment_activated.connect(_on_augment_activated)
	icon.texture = augment.icon
	
	if augment is PermanentAugment:
		cd.hide()
		permanent.show()
	else:
		cd.show()
		permanent.hide()

func get_item() -> Variant:
	return augment

func _process(_delta: float) -> void:
	if augment is TickAugment:
		if snapped(augment.cd_cont*GameTick.tick_interval,1) == 0:
			cd.text = str(snapped(augment.cd,1))
		else:
			cd.text = str(snapped(augment.cd_cont*GameTick.tick_interval,1))
	elif augment is ClickAugment:
		cd.text = str(augment.cd_cont)

func _on_button_pressed() -> void:
	if AugmentEnhanceManager.is_enhancing():
		AugmentEnhanceManager.enhance_augment(augment)

func _on_augment_activated() -> void:
	anim_player.play("activate")
