extends Node2D

@export var button: BaseButton
@export var outline_thickness: float = 1

var outline_shader: Shader = load("uid://cqsd7xibxsf0q")
var outline_shader_material :ShaderMaterial

 
func _ready() -> void:
	button.mouse_entered.connect(_on_mouse_entered)
	button.mouse_exited.connect(_on_mouse_exited)
	#button.pressed.connect(_on_pressed)
	
	outline_shader_material = ShaderMaterial.new()
	outline_shader_material.shader = outline_shader
	button.material = outline_shader_material
	
func _on_mouse_entered() -> void:
	outline_shader_material.set_shader_parameter("outline_thickness", outline_thickness)

func _on_mouse_exited() -> void:
	outline_shader_material.set_shader_parameter("outline_thickness", 0)

	
func _on_pressed() -> void:
	pass
