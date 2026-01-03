extends Node

signal screen_shake()

signal cauldron_click()

signal calculate_mps

signal inventory_changed

#STATS
signal add_mana(mana:float)
signal deduce_mana (mana: float)

#UPGRADES
signal new_upgrade_bought
signal upgrade_bought(upgrade: Upgrade)
signal update_upgrade_info(upgrade: Upgrade)
signal update_stats_labels()
signal upgrade_lvl_up

#SCENE
signal change_scene(scene: GlobalEnum.GAME_SCENE)

#BOSS
signal boss_start()
signal boss_end()
signal update_boss_hp(hp:float)

#AUGMENTS
signal augment_clicked(a:Augment)
signal augment_enhanced()
signal update_augment_info(augment: Augment)

#MENU
signal augment_bought(augment: Augment)
signal reward_selected()
signal shop_disabled(d: bool)
