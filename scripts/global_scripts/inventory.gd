extends Node

var upgrades: Dictionary = {}
var augments: Dictionary = {}

var location = GlobalEnum.LOCATION.INVENTORY

func _ready() -> void:
	_add_upgrades()
	
	#add_augment("Growing leaf")
	#add_augment("Mana potion")
	#add_augment("Mana tree")
	#add_augment("Mighty force")
	#add_augment("Cauldron dogma")
	#add_augment("Mana blessing")
	add_augment("Lucky coin")
	#GameEvents.calculate_mps.connect(_recalculate_permanent_augments)	

func _add_upgrades() -> void:

	for u_name in ResourceManager.upgrades.keys():
		var u: Upgrade = ResourceManager.upgrades[u_name].resource
		add_upgrade(u.name)
		ResourceManager.set_upgrade_location(u.name, location)
		

#AUGMENTS
func add_augment(a_name: String) -> void:
	if !augments.has(a_name):
		var r: ResourceManager.ResourceEntry = ResourceManager.get_augment(a_name, location)
		if r != null:
			var a: Augment = r.resource
			augments[a_name] = a
			ResourceManager.set_augment_location(a_name, location) 
			print("afegim augment ", a_name)
			
			a.on_equip()
			GameEvents.inventory_changed.emit()

func remove_augment(a_name: String) -> void:
	if !augments.has(a_name):
		print("Augment ",a_name , "isn't in the inventory")
	else:
		augments.erase(a_name)
		ResourceManager.set_augment_location(a_name, GlobalEnum.LOCATION.MANAGER)
		GameEvents.inventory_changed.emit()


func reset_augments() -> void:
	for a_name in augments:
		var a: Augment = augments[a_name]
		a.reset()
		
func get_n_augments(type: GlobalEnum.AugmentType) -> int:
	var cont: int = 0
	for a_name in augments.keys():
		var a: Augment = augments[a_name]
		if a.type == type:
			cont += 1
	
	return cont

func get_augments_by_type(type: Object) -> Array:
	var augment_of_type: Array = []
	
	for a_name:String in augments.keys():
		var a: Augment = augments[a_name]
		if is_instance_of(a, type):
			augment_of_type.append(augments[a_name])
	
	return augment_of_type
	
#UPGRADES
func add_upgrade(u_name: String) -> void:
	if !upgrades.has(u_name):
		var u: Upgrade = ResourceManager.get_upgrade(u_name, location)
		if u != null:
			upgrades[u_name] = u
			#print("afegim upgrade ", u_name)
			GameEvents.inventory_changed.emit()


func _on_tick_tick_a() -> void:
	for a_name:String in augments.keys():
		var a: Augment = augments[a_name]
		if a is TickAugment:
			a.tick()
	
	
	
	
	
	
