extends InventoryItem
class_name Augment

@export var type: GlobalEnum.AugmentType
@export var icon: Texture2D


var cd_cont: int
var active_cont: int

func on_equip() -> void:
	assert(false, ("No esta definida la funció on_equip per l'augment " + name))
	pass

func _augment_efect() -> void:
	assert(false, ("No esta definida la funció _augment_efect per l'augment " + name))
	pass


func _calculate_value() -> Big:
	assert(false, ("No esta definida la funció _calculate_value per l'augment " + name))
	return
	
	
	
