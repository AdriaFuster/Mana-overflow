extends Control
class_name Boss

@onready var hp_label: RichTextLabel = %Hp
@onready var animation_player: AnimationPlayer = %AnimationPlayer

const MIN_HIT_ANIM_DURATION: float = 2
const MAX_HIT_ANIM_DURATION: float = 5
const MIN_HITS: float =3
const MAX_HITS: float =10


var hp: Big
signal dead


func _setup() -> void:
	hp = Big.new(100)
	_update_ui()
	
	
	#var total_damage: Big = Big.new(Stats.mana)
	#var step_dmg: Big = Big.new(total_damage)
	#step_dmg.divideEquals(_number_hits)
	#
	#for i:int in range(0, _number_hits):
		#if boss.is_alive :
			#await boss.take_damage(step_dmg)
	
func take_damage(dmg: Big) -> void:
	var ratio :float = BigUtils.clamp(dmg, hp)
	print("---------BOSS-------------")
	print ("hp = ", hp.toAmericanName())
	var n_hits: int = int(lerp(MIN_HITS, MAX_HITS, ratio))
	print ("n_hits = ",n_hits)	
	var anim_duration: float = lerp(MIN_HIT_ANIM_DURATION, MAX_HIT_ANIM_DURATION, ratio)
	print ("anim_duration = ",anim_duration)
	
	var dmg_per_hit := Big.new(dmg.divide(n_hits))
	
	var single_anim_duration: float = get_animation_duration(anim_duration, n_hits)
	print ("single_anim_duration = ",single_anim_duration)
	print ("dmg_per_hit = ",dmg_per_hit.toAmericanName())	
	for i in n_hits:
		if is_alive():
			hp.minusEquals(dmg_per_hit)
			Stats.deduce_mana(dmg_per_hit)
			_update_ui()
			await play_hit_animation(single_anim_duration)
		
		else:
			break
		
	if is_alive():
		hp = Big.new(0)
		dead.emit()


func get_animation_duration(full_anim_duration: float, n_hits: int) -> float:
	var anim_lenght: float = animation_player.get_animation("hurt").length
	var all_anim_lenght: float = anim_lenght * n_hits
	
	if all_anim_lenght >= MIN_HIT_ANIM_DURATION and all_anim_lenght <= MAX_HIT_ANIM_DURATION:
		return anim_lenght
	elif all_anim_lenght < MIN_HIT_ANIM_DURATION:
		var extra_time: float = full_anim_duration - all_anim_lenght
		var single_extra_time: float = extra_time/n_hits
		return single_extra_time + anim_lenght
	else:
		var difference: float = MAX_HIT_ANIM_DURATION/all_anim_lenght
		return anim_lenght*difference


func play_hit_animation(anim_duration: float) -> void:
	var anim_lenght: float = animation_player.get_animation("hurt").length

	var difference: float =  anim_duration - anim_lenght
	print("difference = ",difference)
	if difference < 0:
		print("accelerem animacio")
		var speed_multiplier: float = anim_lenght/anim_duration
		animation_player.play("hurt", -1, speed_multiplier)
		await  animation_player.animation_finished
		
	elif difference > 0:
		print("animacio mes llarga")
		
		animation_player.play("hurt")
		await  animation_player.animation_finished
		await get_tree().create_timer(difference).timeout
	else:
		print("animacio normal")
		animation_player.play("hurt")
		await  animation_player.animation_finished
	
func is_alive() -> bool:
	return hp.isGreaterThan(0)

func _update_ui() -> void:
	if !is_alive():
		hp_label.text = "HP:0"
	else:
		hp_label.text = "HP:"+hp.toAmericanName()
		
