extends CanvasLayer

@onready var hp: RichTextLabel = $Control/MarginContainer/HP

func _ready() -> void:
	Stats.update_player_health.connect(_on_update_player_health)
	hp.text = "Player HP:"+str(Stats.hp)

func _on_update_player_health(new_hp: int) -> void:
	hp.text = "Player HP:"+str(new_hp)
