extends Node

var augments: Dictionary = {}
const  AUGMENTS_DIR: String = "res://resources/augment/"

enum AUGMENT_LOCATION{
	MANAGER,
	SHOP,
	INVENTORY
}

class AugmentEntry:
	var augment: Augment
	var location: AUGMENT_LOCATION
	
	func _init(a: Augment, l: AUGMENT_LOCATION) -> void:
		augment = a
		location = l
		


func _init() -> void:
	_load_augments()
	#for d_key: String in augments.keys():
		#var augment: Augment = augments[d_key].augment
		#print(augment.name)

func get_augment(a_name: String, loc: AUGMENT_LOCATION) -> Augment:
	if augments.has(a_name) and augments[a_name].location != loc:
		return augments[a_name].augment
	print_debug("No s'ha trobat l'augment ", a_name, " al AugmentManager o ja esta a la location demanada")
	return null

func augment_removed(a_name: String, loc: AUGMENT_LOCATION) -> void:
	if augments.has(a_name):
		augments[a_name].location = loc
		

func _load_augments() -> void:
	var dir = DirAccess.open(AUGMENTS_DIR)
	if dir:
		for file in dir.get_files():
			if file.ends_with(".tres"):
				var augment_entry: AugmentEntry = AugmentEntry.new(load(AUGMENTS_DIR + file), AUGMENT_LOCATION.MANAGER) 
				augments[augment_entry.augment.name] = augment_entry
