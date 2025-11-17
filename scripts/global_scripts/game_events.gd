extends Node

signal add_mana(mana: Big)
signal deduce_mana(cost: Big)

signal cauldron_click()

signal calculate_mps

signal inventory_changed

signal new_upgrade_bought

#SHOP
signal augment_bought(augment: Augment)
signal shop_disabled(d: bool)
