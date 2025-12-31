extends CanvasLayer

@onready var augment_list: HBoxContainer = %AugmentList

@export var a_ui_scene: PackedScene
@onready var augments_cont: Label = %AugmentsCont


func _ready() -> void:
	GameEvents.inventory_changed.connect(_on_inventory_changed)
	_on_inventory_changed()

func _on_inventory_changed() -> void:
	_queue_free_children()
	
	augments_cont.text = str(Inventory.n_augments) + "/" + str(Inventory.max_n_augment)
	
	for i_name in Inventory.augments.keys():
		var aug: Augment = Inventory.augments[i_name]
		var aug_ui: AugmentUI = a_ui_scene.instantiate() as AugmentUI
		augment_list.add_child(aug_ui)
		aug_ui.setup(aug)
		

func _queue_free_children() -> void:
	for c in augment_list.get_children():
			c.queue_free()	
			
