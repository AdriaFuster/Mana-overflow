extends Control

@onready var boss: Boss = $Boss
@onready var button: Button = $Button
@onready var text_edit: TextEdit = $TextEdit
@onready var button_2: Button = $Button2


func _ready() -> void:
	button.pressed.connect(_on_dmg)
	button_2.pressed.connect(_on_reset)
	boss._setup()
	
func _on_dmg() -> void:
	var dmg: int = int(text_edit.text)
	boss.take_damage(Big.new(dmg))

func _on_reset() -> void:
	boss._setup()
