extends Control
class_name Boss

@onready var hp_label: RichTextLabel = %Hp
@onready var animation_player: AnimationPlayer = %AnimationPlayer

const MIN_HIT_ANIM_DURATION: float = 2
const MAX_HIT_ANIM_DURATION: float = 5
const MIN_HITS: float =3
const MAX_HITS: float =8
const BOSS_HP_RATE: float = 3

var hp: float
signal dead


func _setup() -> void:
	var boss_range:float = BossSpawner.get_spawn_range()
	hp = round(boss_range/BOSS_HP_RATE)
	hp = 1
	_update_ui()

	
func take_damage(dmg: float) -> void:
	var ratio :float = FloatUtils.clamp(dmg, hp)
	#print("---------BOSS-------------")
	#print ("hp = ", hp)
	var n_hits: int = int(lerp(MIN_HITS, MAX_HITS, ratio))
	#print ("n_hits = ",n_hits)	
	var anim_duration: float = lerp(MIN_HIT_ANIM_DURATION, MAX_HIT_ANIM_DURATION, ratio)
	#print ("anim_duration = ",anim_duration)
	
	var dmg_per_hit: float
	if Comp.greater_equal(dmg, hp):
		dmg_per_hit = hp/n_hits
	else:
		dmg_per_hit = dmg/n_hits
	
	var single_anim_duration: float = animation_player.get_animation_duration(anim_duration, n_hits)
	#print ("single_anim_duration = ",single_anim_duration)
	#print ("dmg_per_hit = ",dmg_per_hit)	
	for i in n_hits:
		if is_alive():
			hp -= dmg_per_hit
			Stats.deduce_mana(dmg_per_hit)
			_update_ui()
			await animation_player.play_hit_animation(single_anim_duration)
		
		else:
			break
		
	if !is_alive():
		hp = 0
		dead.emit()
		
	
func is_alive() -> bool:
	return Comp.greater(hp,0)

func _update_ui() -> void:
	if !is_alive():
		hp_label.text = "HP:0"
	else:
		hp_label.text = "HP:"+ Big.new(hp).sufix()
		
