extends Upgrade
class_name Upgrade1


func _on_pressed():
	Stats.add_upgrade(upgrade_name)
	GameEvents.add_mps.emit(mps_upgrade)
	GameEvents.deduce_mana.emit(cost)
	
	_update_upgrade_amount()
