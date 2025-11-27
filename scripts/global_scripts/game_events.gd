extends Node

signal screen_shake()

signal add_mana(mana: float)
signal deduce_mana(cost: float)

signal cauldron_click()

signal calculate_mps

signal inventory_changed

signal new_upgrade_bought

#SCENE
signal change_scene(scene: GlobalEnum.GAME_SCENE)

#BOSS
signal boss_start()
signal boss_end()

#SHOP
signal augment_bought(augment: Augment)
signal shop_disabled(d: bool)
