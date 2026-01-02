extends Node

const AUGMENT_FILES_ROUTE := "res://resources/augment/"
var all_augments: Array = []
var all_scenes: Array = ["boss", "click"]


func _ready() -> void:
	setup_augment_autocomplete()
	Console.pause_enabled = true
	Console.enable_on_release_build = true
	#STATS
	Console.add_command("add_mana", console_add_mana,["mana"], 1)
	Console.add_command("deduce_mana", console_deduce_mana,["mana"], 1)
	Console.add_command("add_mps", console_add_mps, ["mps"], 1)
	Console.add_command("deduce_mps", console_add_mps, ["mps"], 1)
	
	#AUGMENTS
	Console.add_command("add_augment", console_add_augment, ["augment name"], 1)
	Console.add_command_autocomplete_list("add_augment", all_augments)
	Console.add_command("remove_augment", console_remove_augment, ["augment name"], 1)
	Console.add_command_autocomplete_list("remove_augment", all_augments)
	Console.add_command("enhance_augment", console_enhance_augment, ["augment name"], 1)
	Console.add_command_autocomplete_list("enhance_augment", all_augments)
	Console.add_command("enhancing", console_enhancing)
	#SCENE
	Console.add_command("load_scene", console_load_scene, ["scene_name"], 1)
	Console.add_command_autocomplete_list("load_scene", all_scenes)
	
	#BOSS
	Console.add_command("set_boss_hp", console_set_boss_hp, ["boss_hp"], 1)


func console_add_mana(param: String) -> void:
	var mana = param.to_float()
	Stats.add_mana(mana)
	Console.print_line("Adding %s mana" % mana)

func console_deduce_mana(param: String) -> void:
	var mana = param.to_float()
	Stats.deduce_mana(mana)
	Console.print_line("Deducing %s mana" % mana)

func console_add_mps(param: String) -> void:
	var mps = param.to_float()
	Stats.add_mps(mps)
	Console.print_line("Adding %s mps" % mps)
	
func console_deduce_mps(param: String) -> void:
	var mps = param.to_float()
	Stats.deduce_mps(mps)
	Console.print_line("Deducing %s mps" % mps)

func console_add_augment(augment_name: String) -> void:	
	var augment = load(AUGMENT_FILES_ROUTE+"/"+augment_name+".tres")
	if augment != null:
		Inventory.add_augment(augment.name)

func console_remove_augment(augment_name: String) -> void:	
	var augment = load(AUGMENT_FILES_ROUTE+"/"+augment_name+".tres")
	if augment != null:
		if !Inventory.augments.has(augment.name):
			Console.print_error("Augment "+augment.name+" isn't in the inventory")
		else:
			Inventory.remove_augment(augment.name)
			
func console_enhance_augment(augment_name: String) -> void:
	var augment = load(AUGMENT_FILES_ROUTE+"/"+augment_name+".tres")
	if augment != null:
		if Inventory.augments.has(augment.name):
			var a:Augment = Inventory.augments[augment.name]
			a.enhance()
			#Inventory.remove_augment(augment.name)

func console_enhancing() -> void:
	if 	!AugmentEnhanceManager.is_enhancing():
		AugmentEnhanceManager.start_enhancing()
	else:
		AugmentEnhanceManager.disable_enhance()		

func console_load_scene(scene_name: String) -> void:
	var scene: GlobalEnum.GAME_SCENE
	if scene_name == "boss":
		scene = GlobalEnum.GAME_SCENE.BOSS
	elif scene_name == "click":
		scene = GlobalEnum.GAME_SCENE.CLICK
		
	GameEvents.change_scene.emit(scene)

func console_set_boss_hp(param: String) -> void:
	var boss_hp := param.to_float()
	GameEvents.update_boss_hp.emit(boss_hp)


func setup_augment_autocomplete() -> void:
	var augment_file_list := ResourceLoader.list_directory(AUGMENT_FILES_ROUTE)
	for augment_file_name in augment_file_list:
		var extension := augment_file_name.get_extension()
		# For editor builds
		if (extension == "tres"):
			all_augments.append(augment_file_name.get_basename())
