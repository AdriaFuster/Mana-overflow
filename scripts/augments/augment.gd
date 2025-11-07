extends Resource
class_name Augment

enum AugmentType {
	IDLE,
	CLICK
}

@export var name: String = ""
@export var description: String
@export var type: AugmentType
@export var icon: Texture2D

var cd: float
var duration: float = 0.1


func on_equip() -> void:
	assert(false, ("No esta definida la funció on_equip per l'augment " + name))
	pass

func _augment_efect() -> void:
	assert(false, ("No esta definida la funció _augment_efect per l'augment " + name))
	pass


func _calculate_value() -> Big:
	assert(false, ("No esta definida la funció _calculate_value per l'augment " + name))
	return
	
	
	
