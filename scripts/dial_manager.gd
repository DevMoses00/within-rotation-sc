extends Node2D

@export var dial : AnimatedSprite2D
@export var dial_shadow : AnimatedSprite2D
@export var circles : AnimatedSprite2D
@export var bowl_color: AnimatedSprite2D
@export var mfront: AnimatedSprite2D
@export var floor : AnimatedSprite2D
@export var background : AnimatedSprite2D
@export var marker : Button
@export var camera : Camera2D

signal rotation_complete

enum TitlePhase {
	PHASE_ONE,
	PHASE_TWO,
	PHASE_THREE,
	PHASE_FOUR
}

# current phase variable
var current_phase = TitlePhase.PHASE_ONE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
# handles all the color and rotation changes for four different phases
func rotation_control():
	if current_phase == TitlePhase.PHASE_ONE:
		# rotate dial 90 degrees
		var tween = create_tween()
		tween.tween_property(dial,"rotation_degrees",90,0.4).set_trans(Tween.TRANS_ELASTIC).as_relative()
		tween.parallel().tween_property(dial_shadow, "position", Vector2(50,-15),0.4).set_trans(Tween.TRANS_ELASTIC).as_relative()
		tween.parallel().tween_property(camera,"position",Vector2(0,-100),0.3).set_trans(Tween.TRANS_ELASTIC).as_relative()
		SoundManager.play_sfx("Dial1")
		await tween.finished
		# CHANGE COLORS
		# everything else
		dial.play("red")
		dial_shadow.play("red")
		circles.play("red")
		background.play("red")
		mfront.play("red")
		bowl_color.play("red")
		SoundManager.play_sfx("ColorSingle",0,0,-5)
		print("this is connected")
		# have the marker reappear and ready to be pressed again
		marker.show()
		marker.disabled = false
		# assign the next phase
		current_phase = TitlePhase.PHASE_TWO
	
	elif current_phase == TitlePhase.PHASE_TWO:
	# rotate dial 90 degrees
		var tween = create_tween()
		tween.tween_property(dial,"rotation_degrees",90,0.4).set_trans(Tween.TRANS_ELASTIC).as_relative()
		tween.parallel().tween_property(dial_shadow, "position", Vector2(-50,-15),0.4).set_trans(Tween.TRANS_ELASTIC).as_relative()
		tween.parallel().tween_property(camera,"position",Vector2(100,0),0.3).set_trans(Tween.TRANS_ELASTIC).as_relative()
		SoundManager.play_sfx("Dial2")
		await tween.finished
		# CHANGE COLORS
		# everything else
		dial.play("blue")
		dial_shadow.play("blue")
		circles.play("blue")
		mfront.play("blue")
		background.play("blue")
		bowl_color.play("blue")
		SoundManager.play_sfx("ColorSingle",0,0,2)
		print("this is connected")
		# have the marker reappear and ready to be pressed again
		marker.show()
		marker.disabled = false
		# assign the next phase
		current_phase = TitlePhase.PHASE_THREE

	elif current_phase == TitlePhase.PHASE_THREE:
	# rotate dial 90 degrees
		var tween = create_tween()
		tween.tween_property(dial,"rotation_degrees",90,0.4).set_trans(Tween.TRANS_ELASTIC).as_relative()
		tween.parallel().tween_property(dial_shadow, "position", Vector2(-50,15),0.4).set_trans(Tween.TRANS_ELASTIC).as_relative()
		tween.parallel().tween_property(camera,"position",Vector2(0,100),0.3).set_trans(Tween.TRANS_ELASTIC).as_relative()
		SoundManager.play_sfx("Dial3")
		await tween.finished
		# CHANGE COLORS
		# everything else
		dial.play("pink")
		dial_shadow.play("pink")
		circles.play("pink")
		background.play("pink")
		mfront.play("pink")
		bowl_color.play("pink")
		SoundManager.play_sfx("ColorSingle",0,0,3)
		print("this is connected")
		# have the marker reappear and ready to be pressed again
		marker.show()
		marker.disabled = false
		# assign the next phase
		current_phase = TitlePhase.PHASE_FOUR

	elif current_phase == TitlePhase.PHASE_FOUR:
	# rotate dial 90 degrees
		var tween = create_tween()
		tween.tween_property(dial,"rotation_degrees",90,0.4).set_trans(Tween.TRANS_ELASTIC).as_relative()
		tween.parallel().tween_property(dial_shadow, "position", Vector2(50,15),0.4).set_trans(Tween.TRANS_ELASTIC).as_relative()
		tween.parallel().tween_property(camera,"position",Vector2(-100,0),0.3).set_trans(Tween.TRANS_ELASTIC).as_relative()
		SoundManager.play_sfx("Dial4")
		await tween.finished
		# CHANGE COLORS
		# gumballs first
		# everything else
		dial.play("yellow")
		dial_shadow.play("yellow")
		circles.play("yellow")
		background.play("yellow")
		mfront.play("yellow")
		bowl_color.play("yellow")
		SoundManager.play_sfx("ColorSingle",0,0,2)
		#print("this is connected")
		## have the marker reappear and ready to be pressed again
		#marker.show()
		#marker.disabled = false
		## emit this to signal the next sequence.
		rotation_complete.emit()
		## assign the next phase
		await get_tree().create_timer(7).timeout
		marker.show()
		marker.disabled = false
		current_phase = TitlePhase.PHASE_ONE

# For when the dial marker is clicked
func _on_marker_pressed() -> void:
	print("button_pressed")
	marker.hide()
	SoundManager.play_sfx("Select")
	marker.disabled = true
	rotation_control()
