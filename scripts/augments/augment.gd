extends Resource
class_name Augment

enum AugmentType {
	IDLE,
	CLICK
}

@export var name: String = ""
@export var description: String
@export var tick_rate: float = 1
@export var tick_duration: float = 1
@export var permanent: bool
@export var type: AugmentType
@export var icon: Texture2D

func tick() -> void:
	pass

func augment_efect() -> void:
	pass
