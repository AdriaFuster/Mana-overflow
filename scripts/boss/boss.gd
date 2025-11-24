extends TextureRect
class_name Boss

@onready var hp_label: RichTextLabel = %Hp

var hp: Big
var is_alive: bool
signal dead


func _setup() -> void:
	hp = Big.new(300)
	is_alive = true
	_update_ui()
	
func take_damage(amount: Big) -> void:
	hp.minusEquals(amount)
	if hp.isLessThanOrEqualTo(0):
		is_alive = false
		hp = Big.new(0)
		dead.emit()
	
	_update_ui()
	
func _update_ui() -> void:
	hp_label.text = "HP:"+hp.toAmericanName()
