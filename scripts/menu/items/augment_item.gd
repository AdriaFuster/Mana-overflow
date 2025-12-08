extends Control
class_name AugmentUI

@onready var icon: TextureRect = $Button/TextureRect
@onready var button: TextureButton = $Button
@onready var cd: Label = $Cd
@onready var permanent: TextureRect = $permanent
@onready var anim_player: AnimationPlayer = %AnimationPlayer
@onready var audio: AudioStreamPlayer = $AnimationPlayer/AudioStreamPlayer


var augment: Augment

func _ready() -> void:
	button.pressed.connect(_on_button_pressed)
	GameTick	.tick.connect(_on_tick)

func setup(a: Augment) -> void:
	augment = a
	augment.augment_activated.connect(_on_augment_activated)
	icon.texture = augment.icon
	
	if !augment.cd_indicator:
		cd.hide()
	else:
		cd.show()
		permanent.hide()

func get_item() -> Variant:
	return augment

func _on_tick() -> void:
	if augment is TickAugment:
		var ceil_cd_cont = int(ceil(augment.cd_cont / 10.0))                            
		if ceil_cd_cont == 0:
			cd.text = str(augment.cd)
		else:
			cd.text = str(ceil_cd_cont)

	elif augment is ClickAugment:
		cd.text = str(augment.cd_cont)

func _on_button_pressed() -> void:
	if AugmentEnhanceManager.is_enhancing():
		AugmentEnhanceManager.enhance_augment(augment)

func _on_augment_activated() -> void:
	anim_player.play("activate")
	play_hit_sound()
	pass


func play_hit_sound() -> void:
	audio.play()
