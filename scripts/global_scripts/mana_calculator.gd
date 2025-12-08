extends Node
class_name ManaCalculator

#[augment_name] = mps_modifier
static var permanent_modifiers:Array = []
	
static func reset_mod_values() -> void:
	Stats.mod_cauldron_power = Stats.cauldron_power
	Stats.mod_mps = Stats.mps

static func calculate_cauldron_modifiers() -> void:
	
	for m_name in Stats.cauldron_modifiers.keys():
		Stats.mod_cauldron_power += Stats.cauldron_modifiers[m_name]
		
	_delete_mod(Stats.cauldron_modifiers)

static func calculate_augments() -> void:
	for a_name in Inventory.augments.keys():
		var a: Augment = Inventory.augments[a_name]
		
		if a is PermanentAugment:	
			Stats.mod_mps += a.augment_efect()
		elif a is TickAugment:
			#print("augment ", a.name, " active = ",a.is_active())
			if a.is_active():
				Stats.add_mana(a.augment_efect())
		
	
static func calculate_mana() -> void:
	var tick_mps = Stats.mod_mps
	#tick mps
	tick_mps *= GameTick.tick_interval
	
	Stats.add_mana(tick_mps)
	
	
static func get_permanent_modifiers_mps() -> String:
	var extra_mps := ""	

	for p:PermanentAugment in Inventory.get_augments_by_type(PermanentAugment):
		#print(p.name, " ", p.tick_mps_increment)
		var mps_increment: float = p.tick_mps_increment
		if Comp.greater(mps_increment, 0):
			extra_mps += "+" + Big.new(mps_increment).sufix(true, 2, 3)
			extra_mps += ", "
		elif Comp.less(mps_increment, 0):
			#No need to add - since the negetive increment already has it
			extra_mps += Big.new(mps_increment).sufix(true, 2, 3)
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
