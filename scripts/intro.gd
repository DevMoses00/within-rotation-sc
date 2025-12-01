extends Node2D

# VARIABLES
@export_category("Title Screen Content")
@export var background : AnimatedSprite2D
@export var circles : AnimatedSprite2D
@export var dial : AnimatedSprite2D

@export var dial_shadow : AnimatedSprite2D
@export var title : AnimatedSprite2D
@export var marker : Button

@export_category("Gumballs + Shadow")
@export var gumball1 : AnimatedSprite2D
@export var g1shadow: AnimatedSprite2D
@export var gumball2 : AnimatedSprite2D
@export var g2shadow: AnimatedSprite2D
@export var gumball3 : AnimatedSprite2D
@export var g3shadow: AnimatedSprite2D
@export var gumball4 : AnimatedSprite2D
@export var g4shadow: AnimatedSprite2D


# establish four different phases for visual effects
enum TitlePhase {
	PHASE_ONE,
	PHASE_TWO,
	PHASE_THREE,
	PHASE_FOUR
}
# current phase variable
var current_phase = TitlePhase.PHASE_ONE

# start game variable to show title
var start_game : bool = false

var droplist = ["Drop1","Drop2","Drop3","Drop4"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SoundManager.play_bgs("RoomTone")
	# Ensure the gumballs are hidden
	$Gumballs.hide()
	await get_tree().create_timer(3).timeout
	$Logo.hide()
	await get_tree().create_timer(2).timeout
	# Ensure that the marker UI is on
	SoundManager.play_sfx("Drop1")
	$Circles.show()
	$Dial.show()
	marker.show()
	# SoundManager.play_sfx()
	pass # Replace with function body.

# When button is pressed
func _on_marker_pressed() -> void:
	print("button_pressed")
	marker.hide()
	SoundManager.play_sfx("Select")
	marker.disabled = true
	rotation_control()

# handles all the color and rotation changes for four different phases
func rotation_control():
	if current_phase == TitlePhase.PHASE_ONE:
		# rotate dial 90 degrees
		var tween = create_tween()
		tween.tween_property(dial,"rotation_degrees",90,0.4).set_trans(Tween.TRANS_ELASTIC).as_relative()
		tween.parallel().tween_property(dial_shadow, "position", Vector2(50,-15),0.4).set_trans(Tween.TRANS_ELASTIC).as_relative()
		tween.parallel().tween_property($Camera2D,"position",Vector2(0,-25),0.3).set_trans(Tween.TRANS_ELASTIC).as_relative()
		gumball_feedback()
		SoundManager.play_sfx("Dial1")
		await tween.finished
		# CHANGE COLORS
		# gumballs first
		$Gumballs.visible = true
		gumball1.play("red")
		g1shadow.play("red")
		gumball2.play("yellow")
		g2shadow.play("yellow")
		gumball3.play("pink")
		g3shadow.play("pink")
		gumball4.play("blue")
		g4shadow.play("blue")
		# everything else
		dial.play("red")
		dial_shadow.play("red")
		circles.play("red")
		background.play("red")
		title.play("red")
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
		tween.parallel().tween_property($Camera2D,"position",Vector2(25,0),0.3).set_trans(Tween.TRANS_ELASTIC).as_relative()
		gumball_feedback()
		SoundManager.play_sfx("Dial2")
		await tween.finished
		# CHANGE COLORS
		# gumballs first
		$Gumballs.visible = true
		gumball1.play("blue")
		g1shadow.play("blue")
		gumball2.play("red")
		g2shadow.play("red")
		gumball3.play("yellow")
		g3shadow.play("yellow")
		gumball4.play("pink")
		g4shadow.play("pink")
		# everything else
		dial.play("blue")
		dial_shadow.play("blue")
		circles.play("blue")
		background.play("blue")
		title.play("blue")
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
		tween.parallel().tween_property($Camera2D,"position",Vector2(0,25),0.3).set_trans(Tween.TRANS_ELASTIC).as_relative()
		gumball_feedback()
		SoundManager.play_sfx("Dial3")
		await tween.finished
		# CHANGE COLORS
		# gumballs first
		$Gumballs.visible = true
		gumball1.play("pink")
		g1shadow.play("pink")
		gumball2.play("blue")
		g2shadow.play("blue")
		gumball3.play("red")
		g3shadow.play("red")
		gumball4.play("yellow")
		g4shadow.play("yellow")
		# everything else
		dial.play("pink")
		dial_shadow.play("pink")
		circles.play("pink")
		background.play("pink")
		title.play("pink")
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
		tween.parallel().tween_property($Camera2D,"position",Vector2(-25,0),0.3).set_trans(Tween.TRANS_ELASTIC).as_relative()
		gumball_feedback()
		SoundManager.play_sfx("Dial4")
		await tween.finished
		# CHANGE COLORS
		# gumballs first
		$Gumballs.visible = true
		gumball1.play("yellow")
		g1shadow.play("yellow")
		gumball2.play("pink")
		g2shadow.play("pink")
		gumball3.play("blue")
		g3shadow.play("blue")
		gumball4.play("red")
		g4shadow.play("red")
		# everything else
		dial.play("yellow")
		dial_shadow.play("yellow")
		circles.play("yellow")
		background.play("yellow")
		title.play("yellow")
		SoundManager.play_sfx("ColorSingle",0,0,2)
		print("this is connected")
		# have the marker reappear and ready to be pressed again
		marker.show()
		marker.disabled = false
		# assign the next phase
		current_phase = TitlePhase.PHASE_ONE
		if start_game == false:
			await get_tree().create_timer(1).timeout
			title_appear()

func title_appear():
	$Title.show()
	SoundManager.play_bgs("Title")
	start_game = true
	await get_tree().create_timer(2).timeout
	$start.show()

	

# HELPER 
func gumball_feedback():
	var tween = create_tween()
	tween.tween_property(gumball1,"rotation_degrees",20,-0.4).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(gumball1,"position:x",40,0.4).as_relative().set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(gumball2,"rotation_degrees",20,-0.4).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(gumball2,"position:x",40,0.4).as_relative().set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(gumball3,"rotation_degrees",20,-0.4).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(gumball3,"position:x",40,0.4).as_relative().set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(gumball4,"rotation_degrees",20,-0.4).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(gumball4,"position:x",40,0.4).as_relative().set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(g1shadow,"scale",Vector2(0,-0.2),-0.4).as_relative().set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(g2shadow,"scale",Vector2(0,-0.2),-0.4).as_relative().set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(g3shadow,"scale",Vector2(0,-0.2),-0.4).as_relative().set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(g4shadow,"scale",Vector2(0,-0.2),-0.4).as_relative().set_trans(Tween.TRANS_ELASTIC)
	
	tween.tween_property(gumball1,"rotation_degrees",-20,0.4).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(gumball1,"position:x",-40,0.4).as_relative().set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(gumball2,"rotation_degrees",-20,0.4).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(gumball2,"position:x",-40,0.4).as_relative().set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(gumball3,"rotation_degrees",-20,0.4).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(gumball3,"position:x",-40,0.4).as_relative().set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(gumball4,"rotation_degrees",-20,0.4).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(gumball4,"position:x",-40,0.4).as_relative().set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(g1shadow,"scale",Vector2(0,0.2),-0.4).as_relative().set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(g2shadow,"scale",Vector2(0,0.2),-0.4).as_relative().set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(g3shadow,"scale",Vector2(0,0.2),-0.4).as_relative().set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(g4shadow,"scale",Vector2(0,0.2),-0.4).as_relative().set_trans(Tween.TRANS_ELASTIC)

# start button
func _on_button_pressed() -> void:
	$start.hide()
	$start.disabled = true
	SoundManager.fade_out("Title",2.0)
	SoundManager.play_sfx("Start")
	await get_tree().create_timer(3).timeout
	g1shadow.hide()
	g2shadow.hide()
	g3shadow.hide()
	g4shadow.hide()
	marker.hide()
	marker.disabled = true
	var tween = create_tween()
	tween.tween_property(gumball1,"position:y",400,0.6).as_relative().set_ease(Tween.EASE_OUT_IN).set_trans(Tween.TRANS_BOUNCE)
	tween.parallel().tween_callback(sounddrop)
	tween.tween_property(gumball2,"position:y",400,0.8).as_relative().set_ease(Tween.EASE_OUT_IN).set_trans(Tween.TRANS_BOUNCE)
	tween.parallel().tween_callback(sounddrop)
	tween.tween_property(gumball3,"position:y",400,0.4).as_relative().set_ease(Tween.EASE_OUT_IN).set_trans(Tween.TRANS_BOUNCE)
	tween.parallel().tween_callback(sounddrop)
	tween.tween_property(gumball4,"position:y",400,1.0).as_relative().set_ease(Tween.EASE_OUT_IN).set_trans(Tween.TRANS_BOUNCE)
	tween.parallel().tween_callback(sounddrop)
	await tween.finished
	await get_tree().create_timer(1).timeout
	fade_tween_in($White)
	SoundManager.play_mfx("MLight1")
	await get_tree().create_timer(4.0).timeout
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func sounddrop():
	var key = droplist.pick_random()
	droplist.erase(key)
	SoundManager.play_sfx(key)

func fade_tween_in(image) -> void:
	var fadeTween = get_tree().create_tween()
	fadeTween.tween_property(image,"modulate",Color(1.0, 1.0, 1.0, 1.0), 2)
