extends Node2D

@export var button: BaseButton
@export var hover_scale: Vector2 = Vector2(1.05, 1.05)
@export var pressed_scale: Vector2 = Vector2(0.95, 0.95)

func _ready() -> void:
	button.mouse_entered.connect(_on_mouse_entered)
	button.mouse_exited.connect(_on_mouse_exited)
	button.pressed.connect(_on_pressed)
	call_deferred("_init_pivot")


func _init_pivot() -> void:
	button.pivot_offset = button.size/2

func _on_mouse_entered() -> void:
	create_tween().tween_property(button, "scale", hover_scale, 0.1).set_trans(Tween.TRANS_SINE)

func _on_mouse_exited() -> void:
	create_tween().tween_property(button, "scale", Vector2.ONE, 0.1).set_trans(Tween.TRANS_SINE)

	
func _on_pressed() -> void:
	var button_press_tween: Tween = create_tween()
	button_press_tween.tween_property(button, "scale", pressed_scale, 0.06).set_trans(Tween.TRANS_SINE)
	button_press_tween.tween_property(button, "scale", hover_scale, 0.12).set_trans(Tween.TRANS_SINE)
#
#func _create_hover_animation() -> void:
	#var anim := Animation.new()
	#anim.length = 0.15
	#anim.loop_mode = Animation.LOOP_NONE
#
	## Track per modificar la propietat scale del botó
	#var track := anim.add_track(Animation.TYPE_VALUE)
	#anim.track_set_path(track, str(button.get_path()) + ":scale")
	#anim.track_insert_key(track, 0.0, Vector2(1, 1))
	#anim.track_insert_key(track, 0.10, Vector2(1.1, 1.1))
	##anim.track_insert_key(track, 0.15, Vector2(1, 1))
	#
	#anim_lib.add_animation("hover", anim)
	#anim_player.add_animation_library("",anim_lib)
