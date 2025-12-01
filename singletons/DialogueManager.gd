extends Node

# for the JSON file
var json 

func readJSON(json_file_path):
	var file = FileAccess.open(json_file_path, FileAccess.READ)
	var content = file.get_as_text()
	json = JSON.parse_string(content)
	return json

@onready var text_box_scene = preload("res://scenes/prefabs/text_box.tscn")

var dialogue_lines
var current_line_index = 0

var text_box
var text_box_position : Vector2
var text_box_tween : Tween

var is_dialogue_active = false
var can_advance_line = false


# character animation cues
signal nora
signal albie
signal mira
signal amaro
signal felicity
signal micah
signal basil
signal beatrice


# for the characters talkimg or which side of the screen the text should appear
signal bright
signal bittersweet
signal tart
signal piquant

# used to reset or end the game
signal end_dialogue()

# signals for extra camera affects
signal camera_zoom_signaled
signal camera_reset_signaled
signal endzoom_signaled

# which story chapter we're in
var chapter : String

# signal to show the next picture in a sequence
signal keyboard_image

# list chapters here
signal intro_over



# when a minigame is done

var character_path : String

func _ready() -> void:
	pass

# Create a new dialogue start function that takes a specific set of dialogue lines
func dialogue_player(line_key):
	if is_dialogue_active:
		return
	
	# change the chapter variable to the line key title 
	chapter = line_key
	
	dialogue_lines = json[line_key]
	
	# if this is a regular dialogue line
	_show_text_box()
	is_dialogue_active = true

func _show_text_box():
	# for stage directions
	if dialogue_lines[current_line_index].begins_with("Time:"):
		print("this is working")
		# removes everything but the number in this line
		var timeNum = int(dialogue_lines[current_line_index].to_int())
		print(timeNum)
		can_advance_line = false
		# use it to create a timer based on that int num
		await get_tree().create_timer(timeNum).timeout 
		await get_tree().create_timer(1).timeout
		current_line_index += 1
		_show_text_box()
		return
	
	if dialogue_lines[current_line_index].begins_with("KEYBOARD"):
		print("keyboard change")
		# send a signal
		keyboard_image.emit()
		can_advance_line = false
		await get_tree().create_timer(0.2).timeout
		current_line_index += 1 
		_show_text_box()
		return
	
	if dialogue_lines[current_line_index].begins_with("Zoom"):
		print("camera zoom")
		# send a signal to tween the camera and zoom closer
		camera_zoom_signaled.emit()
		can_advance_line = false
		await get_tree().create_timer(0.2).timeout
		current_line_index += 1 
		_show_text_box()
		return
	
	if dialogue_lines[current_line_index].begins_with("Reset"):
		print("camera reset")
		# send a signal to tween the camera and zoom closer
		camera_reset_signaled.emit()
		can_advance_line = false
		await get_tree().create_timer(0.2).timeout
		current_line_index += 1 
		_show_text_box()
		return
	
	if dialogue_lines[current_line_index].begins_with("Endzoom"):
		print("engage end protocol")
		# send a signal to tween the camera and zoom closer
		endzoom_signaled.emit()
		can_advance_line = false
		await get_tree().create_timer(0.2).timeout
		current_line_index += 1 
		_show_text_box()
		return
		
	
	if dialogue_lines[current_line_index].begins_with("FMachine"):
		print("flip machine card")
		# send a signal to flip card
		
		can_advance_line = false
		await get_tree().create_timer(0.6).timeout
		current_line_index += 1 
		_show_text_box()
		return
	
	# Audio Commands
	if dialogue_lines[current_line_index].begins_with("Template"):
		print("play sounds")
		# Sound Manager play lager G
		#SoundManager.fade_in_mfx(" ",2.0)
		#SoundManager.fade_out(" ",22.0)
		can_advance_line = false
		await get_tree().create_timer(0.2).timeout
		current_line_index += 1 
		_show_text_box()
		return
	
	text_box = text_box_scene.instantiate()
	text_box.finished_displaying.connect(_on_text_box_finished_displaying)
	get_tree().root.add_child(text_box)
	
	if dialogue_lines[current_line_index].begins_with("I:"):
		text_box.global_position = Vector2(0, -1175)
	
	elif dialogue_lines[current_line_index].begins_with("Nora:"):
		#text_box.get_child(0).hide()
		text_box.global_position = Vector2(0, 1580)
		#text_box.bright.visible = true
		bright.emit()
		nora.emit()
	
	elif dialogue_lines[current_line_index].begins_with("Albie:"):
		text_box.global_position = Vector2(0, 1580)
		#text_box.bright.visible = true
		bright.emit()
		albie.emit()
	
	elif dialogue_lines[current_line_index].begins_with("Mira:"):
		text_box.global_position = Vector2(0, 1580)
		#text_box.bittersweet.visible = true
		bittersweet.emit()
		mira.emit()
	
	elif dialogue_lines[current_line_index].begins_with("Amaro:"):
		text_box.global_position = Vector2(0, 1580)
		#text_box.bittersweet.visible = true
		bittersweet.emit()
		amaro.emit()
	
	elif dialogue_lines[current_line_index].begins_with("Beatrice:"):
		text_box.global_position = Vector2(0, 1580)
		#text_box.piquant.visible = true
		piquant.emit()
		beatrice.emit()
	
	elif dialogue_lines[current_line_index].begins_with("Basil:"):
		text_box.global_position = Vector2(0, 1580)
		#text_box.piquant.visible = true
		piquant.emit()
		basil.emit()
	
	elif dialogue_lines[current_line_index].begins_with("Felicity:"):
		text_box.global_position = Vector2(0, 1580)
		#text_box.piquant.visible = true
		tart.emit()
		felicity.emit()
	
	elif dialogue_lines[current_line_index].begins_with("Micah:"):
		text_box.global_position = Vector2(0, 1580)
		#text_box.piquant.visible = true
		tart.emit()
		micah.emit()
	
	
	#tween animation - No tween animation for May 2025 VM Game
	#text_box_tween = get_tree().create_tween().set_loops()
	#text_box_tween.tween_interval(0.1)
	#text_box_tween.tween_property(text_box, "position:x",-5,0.1).as_relative()
	#text_box_tween.tween_interval(0.5)
	#text_box_tween.tween_property(text_box, "position:x",5,0.1).as_relative()
	#text_box_tween.tween_interval(0.5)
		   #
	text_box.display_text(dialogue_lines[current_line_index])
	# Play a random set of from soundmanager
	#var sfx_standard = ["TextA","TextB","TextC"].pick_random()
	#SoundManager.play_sfx(sfx_standard,0,-15)
	can_advance_line = false

func _on_text_box_finished_displaying():
	print("working")
	can_advance_line = true


func _unhandled_input(event: InputEvent) -> void:
	if (
		event.is_action_pressed("advance_dialogue") &&
		is_dialogue_active &&
		can_advance_line
	):
		if is_instance_valid(text_box):
			#text_box_tween.kill() # kill the tween loop
			text_box.queue_free()      
		
		current_line_index += 1
		
		
		if current_line_index >= dialogue_lines.size():
			is_dialogue_active = false
			current_line_index = 0
			# send a signal saying that this line is over and a new action must occur?
			if chapter == "Intro":
				intro_over.emit()
			else: 
				end_dialogue.emit()
			return
		
		_show_text_box()


func skip_dialogue():
	current_line_index = int(dialogue_lines.size())
	#text_box.queue_free()
	#text_box_tween.kill()
	# have their mouths stop moving
	#stop_talking.emit()
	# send a signal saying that this line is over and a new action must occur?
	#choice_make.emit()
	return
