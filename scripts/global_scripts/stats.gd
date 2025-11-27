extends Node

enum MODIFIER_TYPE {
	MANA,
	MPS
}

var mana: float = 99
var mps: float = 0
var tick_mana: float


var mod_mps: float = 0
var cauldron_power: float = 1
var mod_cauldron_power: float = 1

#MODIFIERS
var tick_modifiers_mps: Dictionary = {}
var permanent_modifiers_mps: Dictionary = {}
var active_modifiers_mana: Dictionary = {}
var cauldron_modifiers: Dictionary = {}


func _ready() -> void:
	GameEvents.add_mana.connect(_on_add_mana)
	GameEvents.deduce_mana.connect(_on_deduced_mana)
	GameEvents.calculate_mps.connect(_on_calculate_mps)
	GameEvents.change_scene.connect(_on_change_scene)
		

#MANA
func add_mana(n_mana: float) -> void:
	mana += n_mana

func deduce_mana(n_mana: float) -> void:
	if Comp.less((mana - n_mana), 0):
		mana = 0
	else:
		mana -= n_mana
	
		
#MODIFIERS
func add_tick_modifier(m_name: String, value: float, type: MODIFIER_TYPE) -> void:
	#print ("add to tick modifier ",m_name )
	if type == MODIFIER_TYPE.MPS:	
		#print("afegim als mps ",Stats.mps.toAmericanName(), " ", percent+1)
		tick_modifiers_mps[m_name] = value
	else:
		#print("afegim al mana ",Stats.mana.toAmericanName(), " ", percent+1)
		tick_modifiers_mps[m_name] = value

func add_permanent_modifier(m_name: String, value: float, type: MODIFIER_TYPE) -> void:
	#print ("add to permanent modifier ",m_name )
	if type == MODIFIER_TYPE.MPS:	
		#print("afegim als mps ",Stats.mps.toAmericanName(), " ", percent+1)
		permanent_modifiers_mps[m_name] = value

func add_cauldron_modifier(m_name: String, value: float) -> void:
	cauldron_modifiers[m_name] = value

func remove_tick_modifier(m_name: String, type: MODIFIER_TYPE) -> void:
	if type == MODIFIER_TYPE.MPS:	
		tick_modifiers_mps.erase(m_name)
	else:
		tick_modifiers_mps.erase(m_name)

func remove_permanent_modifier(m_name: String, type: MODIFIER_TYPE) -> void:
	if type == MODIFIER_TYPE.MPS:	
		permanent_modifiers_mps.erase(m_name)

func remove_cauldron_modifier(m_name: String) -> void:
	cauldron_modifiers.erase(m_name)
	
	
#UPGRADES
var upgrades: Dictionary = {}

#func get_upgrade_amount(upgrade: Upgrade) -> int:
	#if upgrades.has(upgrade):
		#return upgrades[upgrade]
	#return 0
#
#func add_upgrade(upgrade: Upgrade, amount: int = 1):
	#upgrades[upgrade] = get_upgrade_amount(upgrade) + amount


func _on_add_mana(mana_add: float):
	add_mana(mana_add)
	
func _on_deduced_mana(mana_deduced: float):
	deduce_mana(mana_deduced)

	
func _on_calculate_mps() -> void:
	var total_mps: float = 0
	
	for u_name:String in Inventory.upgrades.keys():
		var u: Upgrade = Inventory.upgrades[u_name]
		total_mps += u.mps*u.amount
	
	mps = total_mps


func _on_change_scene(scene: GlobalEnum.GAME_SCENE) -> void:
	if scene == GlobalEnum.GAME_SCENE.BOSS:
		#Save mana value o tick mana
		tick_mana = mana
		mana = 0
		
	elif scene == GlobalEnum.GAME_SCENE.CLICK:
		mana = tick_mana
