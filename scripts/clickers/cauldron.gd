extends Control
class_name Cauldron

@onready var cauldron: CauldronAnimations = %TextureButton

func _ready() -> void:
	cauldron.pressed.connect(_on_pressed)
	
func _process(_delta):
	if is_visible_in_tree():
		if Input.is_action_just_pressed("cauldron_click"):
			_on_pressed()
	
func _on_pressed() -> void:
	Stats.add_mana(Stats.mod_cp)
	GameEvents.cauldron_click.emit()
	cauldron.cauldron_click_anim()


func disable_button(b_disabled: bool) -> void:
	cauldron.disabled = b_disabled


func show_cauldron(c_show: bool) -> void:
	self.visible = 	c_show
