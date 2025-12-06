extends Node
class_name ManaCalculator

static func reset_mod_values() -> void:
	Stats.mod_cauldron_power = Stats.cauldron_power
	Stats.mod_mps = Stats.mps

static func calculate_cauldron_modifiers() -> void:
	Stats.mod_cauldron_power = Stats.cauldron_power
	
	for m_name in Stats.cauldron_modifiers.keys():
		Stats.mod_cauldron_power += Stats.cauldron_modifiers[m_name]
		
	_delete_mod(Stats.cauldron_modifiers)

static func calculate_permanent_modifiers() -> void:
	Stats.mod_mps = Stats.mps
	
	for m_name in Stats.permanent_modifiers_mps.keys():
		Stats.mod_mps += Stats.permanent_modifiers_mps[m_name]
		#print(m_name)

		#print(Stats.permanent_modifiers_mps[m_name])
	_delete_mod(Stats.permanent_modifiers_mps)
	
static func get_permanent_modifiers_mps() -> String:
	var extra_mps := ""	
	#print(Stats.permanent_modifiers_mps)
	for m_name in Stats.permanent_modifiers_mps.keys():
		#print(Stats.permanent_modifiers_mps[m_name])
		extra_mps += str(Stats.permanent_modifiers_mps[m_name])
		extra_mps += ", "
	
	extra_mps = extra_mps.rstrip(", ")
	
	return extra_mps


static func calculate_tick_modifiers():
	var tick_mps = Stats.mod_mps
	
	#tick mps
	tick_mps *= GameTick.tick_interval
	
	var final_mps:float = tick_mps
	
	#Add tick modifiers
	for m_name in Stats.tick_modifiers_mps.keys():
		final_mps += Stats.tick_modifiers_mps[m_name]
	
	_delete_mod(Stats.tick_modifiers_mps)
	
	Stats.add_mana(final_mps)
	
	

static func _delete_mod(d: Dictionary) -> void:
	
	for m_name in d.duplicate():
		d.erase(m_name)
