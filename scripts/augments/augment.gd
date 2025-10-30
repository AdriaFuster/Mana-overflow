extends Node2D
class_name Augment

@export var augment_res: AugmentResource
@onready var upgrade: UpgradeAnimations = %TextureButton
@onready var cost_label: Label = %CostLabel
@onready var amount_label: Label = %AmountLabel
@onready var description_label: Label = %Description


const MULTIPLIER_RATE: float = 1.15

func _ready() -> void:
	_setup()

func _setup():
	description_label.text = str(augment_res.description)
	pass
	
