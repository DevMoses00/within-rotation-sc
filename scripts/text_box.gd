extends MarginContainer

@onready var label = $MarginContainer/Label
@onready var timer = $LetterDisplayTimer

@export var bright : NinePatchRect
@export var bittersweet : NinePatchRect
@export var tart : NinePatchRect
@export var piquant : NinePatchRect

var MAX_WIDTH = 1200

var text = ""
var letter_index = 0

# how many seconds will pass between each letter character displayed
var letter_time = 0.0000000001
var space_time = 0.00001
var punctuation_time = 0.2

signal finished_displaying()

func display_text(text_to_display: String):
	
	# dialogue tags
	# for Left Side Narration
	if text_to_display.begins_with("I: "):
		text_to_display = text_to_display.trim_prefix("I: ")
		$MarginContainer/Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	elif text_to_display.begins_with("Nora: "):
		text_to_display = text_to_display.trim_prefix("Nora: ")
		$MarginContainer/Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	elif text_to_display.begins_with("Albie: "):
		text_to_display = text_to_display.trim_prefix("Albie: ")
		$MarginContainer/Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	elif text_to_display.begins_with("Mira: "):
		text_to_display = text_to_display.trim_prefix("Mira: ")
		$MarginContainer/Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	elif text_to_display.begins_with("Amaro: "):
		text_to_display = text_to_display.trim_prefix("Amaro: ")
		$MarginContainer/Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	elif text_to_display.begins_with("Felicity: "):
		text_to_display = text_to_display.trim_prefix("Felicity: ")
		$MarginContainer/Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	elif text_to_display.begins_with("Micah: "):
		text_to_display = text_to_display.trim_prefix("Micah: ")
		$MarginContainer/Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	elif text_to_display.begins_with("Beatrice: "):
		text_to_display = text_to_display.trim_prefix("Beatrice: ")
		$MarginContainer/Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	elif text_to_display.begins_with("Basil: "):
		text_to_display = text_to_display.trim_prefix("Basil: ")
		$MarginContainer/Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	# Do one for all the other characters too
	
	
	text = text_to_display
	label.text = text_to_display # label expands to the full width of the text
	
	if text.length() > 5:
		await resized
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	# resizing all the other character text boxes
	bright.custom_minimum_size.x = min(size.x, MAX_WIDTH)
	bittersweet.custom_minimum_size.x = min(size.x, MAX_WIDTH)
	tart.custom_minimum_size.x = min(size.x, MAX_WIDTH)
	piquant.custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		#await resized # wait for x resize
		#await resized # wait for y resize
		custom_minimum_size.y = size.y
		
		# resizing all the other character text boxes
		bright.custom_minimum_size.y = size.y
		bittersweet.custom_minimum_size.y = size.y
		tart.custom_minimum_size.y = size.y
		piquant.custom_minimum_size.y = size.y
		
	# POSITIONING - NOT SURE I NEED THIS
	global_position.x -= (size.x / 2) 
	global_position.y -= (size.y + 24) 
	
	label.text = ""
	_display_letter()

func _display_letter():
	label.text += text[letter_index]
	
	letter_index += 1
	if letter_index >= text.length():
		finished_displaying.emit()
		return
	
	# if there are still letter characters to display
	match text[letter_index]:
		"!", ".", ",", "?","-":
			timer.start(punctuation_time)
		" ":
			timer.start(space_time)
			# play a sound every time there is a space
			var sfx_standard = ["Drop1", "Drop2"].pick_random()
			SoundManager.play_sfx(sfx_standard,0,-15)
		_:
			timer.start(letter_time)

func _on_letter_display_timer_timeout() -> void:
	_display_letter()
