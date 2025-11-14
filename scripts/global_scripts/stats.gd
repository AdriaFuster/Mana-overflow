extends Node

enum MODIFIER_TYPE {
	MANA,
	MPS
}

var mana = Big.new(0)
var mps = Big.new(0)
var mod_mps = Big.new(0)
var cauldron_power: float = 1
var mod_cauldron_power: float = 1

#MODIFIERS
var tick_modifiers_mps: Dictionary = {}
var permanent_modifiers_mps: Dictionary = {}
var active_modifiers_mana: Dictionary = {}
var cauldron_modifiers: Dictionary = {}

func add_tick_modifier(m_name: String, value: Big, type: MODIFIER_TYPE) -> void:
	print ("add to tick modifier ",m_name )
	if type == MODIFIER_TYPE.MPS:	
		#print("afegim als mps ",Stats.mps.toAmericanName(), " ", percent+1)
		tick_modifiers_mps[m_name] = value
	else:
		#print("afegim al mana ",Stats.mana.toAmericanName(), " ", percent+1)
		tick_modifiers_mps[m_name] = value

func add_permanent_modifier(m_name: String, value: Big, type: MODIFIER_TYPE) -> void:
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
