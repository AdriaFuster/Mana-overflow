extends Control

@onready var cauldron_power: RichTextLabel = %CauldronPower
@onready var mana_label: RichTextLabel = %Mana
@onready var mps_label: RichTextLabel = %MPS
@onready var hp: RichTextLabel = %HP

func _ready() -> void:
	_display_values()
	GameEvents.update_stats_labels.connect(_display_values)
	
	Stats.update_player_health.connect(_on_update_player_health)
	hp.text = "Player HP = "+str(Stats.hp)
	
func _display_values():
	mana_label.text = "Mana = " + Big.new(Stats.mana).sufix(true,1,3, false)
	mps_label.text = "MPS = " + Big.new(Stats.mod_mps).sufix()
	mps_label.update_minimum_size()

	cauldron_power.text = "CP = " + Big.new(Stats.mod_cauldron_power).sufix()
	

func _on_update_player_health(new_hp: int) -> void:
	hp.text = "Player HP = "+str(new_hp)
