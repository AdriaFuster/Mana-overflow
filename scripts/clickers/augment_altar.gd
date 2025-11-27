extends Node2D

@onready var button: TextureButton = %button
var shop_opened: bool = false

func _ready() -> void:
	button.pressed.connect(_on_pressed)
	GameEvents.shop_disabled.connect(_on_shop_disabled)
	disable_button(true)


func _on_pressed() -> void:
	if !shop_opened:
		Shop.show_shop()
		shop_opened = true
	else:
		Shop.hide_shop()
		shop_opened = false

func _on_shop_disabled(d: bool) -> void:
	if d:
		disable_button(true)
	else:
		disable_button(false)

func disable_button(disable: bool) -> void:
	if disable:
		button.disabled = true
		modulate.a = 0.5
	else:
		button.disabled = false
		modulate.a = 1 
		shop_opened = false
