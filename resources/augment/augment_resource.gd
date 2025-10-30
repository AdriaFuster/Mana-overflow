extends Resource
class_name AugmentResource

enum AugmentType {
	IDLE,
	CLICK
}

@export var name: String = "upgrade"
@export var description: String
@export var tick_rate: float = 1
@export var tick_duration: float = 1
@export var permanent: bool
@export var type: AugmentType
