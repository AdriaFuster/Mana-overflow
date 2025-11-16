extends Control
class_name UpgradeUI

@onready var button: TextureButton = %TextureButton
@onready var cost: Label = %Cost
@onready var icon: TextureRect = %Icon
@onready var amount: Label = %Amount
var upgrade: Upgrade

var icon_mat: ShaderMaterial


func _ready() -> void:
	button.pressed.connect(_on_pressed)


func setup(u:Upgrade) -> void:
	icon.texture = u.icon
	cost.text = u.cost.toAmericanName()
	upgrade = u
	amount.text = str(0)
	
	icon_mat = icon.material
	u.update_cost.connect(_on_update_cost)
	u.update_amount.connect(_on_update_amount)

func _process(_delta: float) -> void:
	_set_state()


func _set_state() -> void:
	if upgrade.locked:
		icon_mat.set_shader_parameter("use_silhouette", true)
		button.disabled = true
		modulate.a = 0.5
		
	else:
		icon_mat.set_shader_parameter("use_silhouette", false)
		
		if Stats.mana.isGreaterThanOrEqualTo(upgrade.cost):
			button.disabled = false
			modulate.a = 1
		
		else:
			button.disabled = true
			modulate.a = 0.5


func _on_pressed() -> void:
	upgrade.upgrade_click()


func _on_update_cost(new_cost: Big) -> void:
	cost.text = new_cost.toAmericanName()
	
	
func _on_update_amount(new_amount: int) -> void:
	amount.text = str(new_amount)
	

func _on_texture_button_mouse_entered() -> void:
	ItemPopup.item_popup(Rect2i(Vector2i(button.global_position), Vector2i(size)), 
	upgrade, ItemPopup.DISTRIBUTION_MODE.VERTICAL)


func _on_texture_button_mouse_exited() -> void:
	ItemPopup.hide_item_popup()
