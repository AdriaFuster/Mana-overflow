extends Node

enum MODIFIER_TYPE {
	MANA,
	MPS
}
var mana: float = 0
var mana_spent: float = 0
var mps: float = 0
var mod_mps: float = 0

var tick_mana: float
var hp: int = 3

var cauldron_power: float = 1
var mod_cauldron_power: float = 1

#MODIFIERS
var tick_modifiers_mps: Dictionary = {}
var permanent_modifiers_mps: Dictionary = {}
var active_modifiers_mana: Dictionary = {}
var cauldron_modifiers: Dictionary = {}

signal update_player_health(health: int)
signal player_dead()

func _ready() -> void:
	GameEvents.calculate_mps.connect(_on_calculate_mps)
	GameEvents.add_mana.connect(_on_add_mana)
	GameEvents.deduce_mana.connect(_on_deduced_mana)

#MANA
func add_mana(n_mana: float) -> void:
	mana += n_mana

func spend_mana(n_mana: float) -> void:
	mana_spent += n_mana
	
func deduce_mana(n_mana: float) -> void:
	if Comp.less_equal((mana - n_mana), 0):
		mana = 0
	else:
		mana -= n_mana
	
func add_mps(a_mps) -> void:
	mps += a_mps

func deduce_mps(d_mps) -> void:
	if Comp.less_equal((mps - d_mps), 0):
		mps = 0
	else:
		mps -= d_mps
	
func add_hp(p_hp: int) -> void:
	if (hp + p_hp) == 0:
		hp = 0
		#player_dead.emit()
		get_tree().quit()
	else:
		hp += p_hp
	
	update_player_health.emit(hp)
	
#MODIFIERS
func add_tick_modifier(m_name: String, value: float, type: MODIFIER_TYPE) -> void:
	#print ("add to tick modifier ",m_name )
	if type == MODIFIER_TYPE.MPS:	
		tick_modifiers_mps[m_name] = value
	else:
		tick_modifiers_mps[m_name] = value

func add_permanent_modifier(m_name: String, value: float, type: MODIFIER_TYPE) -> void:
	#print ("add to permanent modifier ",m_name )
	if type == MODIFIER_TYPE.MPS:
		if permanent_modifiers_mps.has(m_name):
			
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
	
	
func _on_add_mana(mana_add: float):
	add_mana(mana_add)
	
func _on_deduced_mana(mana_deduced: float):
	deduce_mana(mana_deduced)
	
	
func _on_calculate_mps() -> void:
	#print("--------------")
	var total_mps: float = 0
	for u_name:String in Inventory.upgrades.keys():
		var u: Upgrade = Inventory.upgrades[u_name]
		if (u.amount > 0):
			#print(u.name, " ",u.mps, " ", u.amount )
			#print ("u.mps*u.amount ", u.mps*u.amount)
			total_mps += u.mps*u.amount
			#print ("total_mps ", total_mps)
	
	mps = total_mps

func change_scene(scene: GlobalEnum.GAME_SCENE) -> void:
	if scene == GlobalEnum.GAME_SCENE.BOSS:
		#Save mana value o tick mana
		tick_mana = mana
		mana = 0
		
	elif scene == GlobalEnum.GAME_SCENE.CLICK:
		mana = tick_mana
