extends Control
class_name Boss

@onready var hp_label: RichTextLabel = %Hp
@onready var animation_player: AnimationPlayer = %AnimationPlayer

const HIT_ANIM_MIN_DURATION: float = 4
const HIT_ANIM_MAX_DURATION: float =10
const MIN_HITS: float =6
const MAX_HITS: float =40


var hp: Big
var is_alive: bool
signal dead


func _setup() -> void:
	hp = Big.new(50)
	is_alive = true
	_update_ui()
	
	
	#var total_damage: Big = Big.new(Stats.mana)
	#var step_dmg: Big = Big.new(total_damage)
	#step_dmg.divideEquals(_number_hits)
	#
	#for i:int in range(0, _number_hits):
		#if boss.is_alive :
			#await boss.take_damage(step_dmg)
	
func take_damage(dmg: Big) -> void:
	var scale_dmg:Big = dmg.divide(100)
	var scale := clamp(scale_dmg, 0.0, 1.0)
	
	hp.minusEquals(dmg)
	animation_player.play("hurt")
	await  animation_player.animation_finished
	
	if hp.isLessThanOrEqualTo(0):
		is_alive = false
		hp = Big.new(0)
		dead.emit()
	
	_update_ui()




func _update_ui() -> void:
	hp_label.text = "HP:"+hp.toAmericanName()
