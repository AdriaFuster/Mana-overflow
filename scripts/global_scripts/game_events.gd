extends Node

signal screen_shake()

signal cauldron_click()

signal calculate_mps

signal inventory_changed

signal new_upgrade_bought

signal add_mana(mana:float)
signal deduce_mana (mana: float)

#SCENE
signal change_scene(scene: GlobalEnum.GAME_SCENE)

#BOSS
signal boss_start()
signal boss_end()

#AUGMENTS
signal augment_clicked(a:Augment)
signal augment_enhanced()


#MENU
signal augment_bought(augment: Augment)
signal reward_selected()
signal shop_disabled(d: bool)

#UPGRADE
signal update_info(upgrade: Upgrade)
