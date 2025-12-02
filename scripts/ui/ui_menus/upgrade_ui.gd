extends Control
class_name UpgradeUI

@onready var button: TextureButton = %TextureButton
@onready var cost: RichTextLabel = %Cost
@onready var icon: TextureRect = %Icon
@onready var amount: RichTextLabel = %Amount
var upgrade: Upgrade

var icon_mat: ShaderMaterial


func _ready() -> void:
	button.pressed.connect(_on_pressed)


func setup(u:Upgrade) -> void:
	upgrade = u
	icon.texture = upgrade.icon
	cost.text = TextUtils.bold(Big.new(upgrade.cost).sufix())
	amount.text = TextUtils.bold(str(upgrade.amount))
	
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
		
		if Comp.greater_equal(Stats.mana,upgrade.cost):
			button.disabled = false
			modulate.a = 1
		
		else:
			button.disabled = true
			modulate.a = 0.5


func _on_pressed() -> void:
	upgrade.upgrade_click()


func _on_update_cost(new_cost: float) -> void:
	cost.text = TextUtils.bold(Big.new(new_cost).sufix())
	
	
func _on_update_amount(new_amount: int) -> void:
	amount.text = TextUtils.bold(str(new_amount))
	

func _on_texture_button_mouse_entered() -> void:
	PopupManager.show_popup(GlobalEnum.POPUP_TYPE.UPGRADE,
	Rect2i(Vector2i(global_position), Vector2i(size)), 
	upgrade, 
	GlobalEnum.DISTRIBUTION_MODE.VERTICAL)


func _on_texture_button_mouse_exited() -> void:
	PopupManager.hide_popup()
