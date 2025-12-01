extends Node2D

# list of characters in the game to pull from
var character_list : Array = [
["Nora", "Bright"], #0
["Albie","Bright"], #1
["Mira","Bittersweet"], #2
["Amaro","Bittersweet"], #3
["Micah","Tart"], #4
["Felicity", "Tart"], #5
["Beatrice", "Piquant"], #6
["Basil","Piquant"] #7
]

#var active_list : Array

@export_category("Character Sets")
@export var circleA : AnimatedSprite2D
@export var circleB : AnimatedSprite2D
@export var chA : AnimatedSprite2D
@export var chB : AnimatedSprite2D
@export var miniA : AnimatedSprite2D
@export var miniB : AnimatedSprite2D
var gumballA : RigidBody2D # taking the child sprite texture because that might work better
var gumballB : RigidBody2D

# the dialogue pair that will be used
var chosen_pair := []

# read through the json specifically to check for the right combo of characters
var json 
var data

signal force_end

func readJSON(json_file_path):
	var file = FileAccess.open(json_file_path, FileAccess.READ)
	var content = file.get_as_text()
	data = JSON.parse_string(content)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.readJSON("res://dialogue/within_rotation_dialogue.json")
	# parsing it locally to check for the right combination
	readJSON("res://dialogue/within_rotation_dialogue.json")
	signals_connect()
	Globals.active_list = Globals.character_list.duplicate(true)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func signals_connect():
	DialogueManager.bright.connect(change_to_bright)
	DialogueManager.bittersweet.connect(change_to_bittersweet)
	DialogueManager.tart.connect(change_to_tart)
	DialogueManager.piquant.connect(change_to_piquant)
	
	# Character connects
	DialogueManager.nora.connect(nora_speaking)
	DialogueManager.albie.connect(albie_speaking)
	DialogueManager.mira.connect(mira_speaking)
	DialogueManager.amaro.connect(amaro_speaking)
	DialogueManager.felicity.connect(felicity_speaking)
	DialogueManager.micah.connect(micah_speaking)
	DialogueManager.beatrice.connect(beatrice_speaking)
	DialogueManager.basil.connect(basil_speaking)

func shuffle_and_draw():
	Globals.active_list.shuffle()
	chosen_pair = Globals.active_list.slice(0,2)
	print(chosen_pair)
	# remove the first two in the original character list
	Globals.active_list.remove_at(0)
	Globals.active_list.remove_at(0)
	print(Globals.active_list)
	if Globals.active_list.is_empty() == true:
		print("All done!")
		force_end.emit()

func assign_gumballs():
	#Assign the Gumball Character
	var keyA = str(chosen_pair[0][1])
	var keyB = str(chosen_pair[1][1])
	
	Globals.keyA = keyA
	Globals.keyB = keyB
	var textureA
	var textureB
	
	
	print(keyA)
	print(keyB)
	
	
	#if keyA == "Bright":
		#Globals.textureA = load("res://art/intro/wr_gumballs/blue_gumball.png")
		##gumballA.sprite = textureA 
	#if keyA == "Bittersweet":
		#Globals.textureA = load("res://art/intro/wr_gumballs/pink_gumball.png")
		##gumballA.sprite = textureA 
	#if keyA == "Tart":
		#Globals.textureA = load("res://art/intro/wr_gumballs/yellow_gumball.png")
		##gumballA.sprite = textureA 
	#if keyA == "Piquant":
		#Globals.textureA = load("res://art/intro/wr_gumballs/red_gumball.png")
		##gumballA.sprite = textureA 
#
	#if keyB == "Bright":
		#Globals.textureB = load("res://art/intro/wr_gumballs/blue_gumball.png")
	#if keyB == "Bittersweet":
		#Globals.textureB = load("res://art/intro/wr_gumballs/pink_gumball.png")
	#if keyB == "Tart":
		#Globals.textureB = load("res://art/intro/wr_gumballs/yellow_gumball.png")
	#if keyB == "Piquant":
		#Globals.textureB = load("res://art/intro/wr_gumballs/red_gumball.png")
	
	
	
	
	
func assign_scene():
	# Assign the circles
	circleA.play(str(chosen_pair[0][1]))
	circleB.play(str(chosen_pair[1][1]))
	
	# Assign the character portraits
	chA.play(str(chosen_pair[0][0]))
	chB.play(str(chosen_pair[1][0]))
	
	# Assign the Mini Characters
	miniA.play(str(chosen_pair[0][0]))
	miniB.play(str(chosen_pair[1][0]))
	
	# Assign the name titles
	$CharacterATitle.text = str(chosen_pair[0][0]).to_upper()
	$CharacterBTitle.text = str(chosen_pair[1][0]).to_upper()



func set_dialogue():
	# save character names
	var chaKeyA = str(chosen_pair[0][0])
	var chaKeyB = str(chosen_pair[1][0])
	var num = str(randi_range(1,1))
	
	var dialogue = chaKeyA + "_" + chaKeyB + "_" + num
	print(dialogue)
	if data.has(dialogue):
		dialogue_go(dialogue)
	else: 
		print("corrected")
		dialogue = chaKeyB + "_" + chaKeyA + "_" + num
		dialogue_go(dialogue)
	
# COLOR FUNCTIONS
func change_to_bright():
	$Shadow.play("Bright")

func change_to_bittersweet():
	$Shadow.play("Bittersweet")

func change_to_tart():
	$Shadow.play("Tart")

func change_to_piquant():
	$Shadow.play("Piquant")


# CHARACTER FUNCTIONS
func nora_speaking():
	miniA.stop()
	miniB.stop()
	if chA.animation == "Nora": 
		quick_tween(circleA)
		miniA.play()
	elif chB.animation == "Nora":
		quick_tween(circleB)
		miniB.play()

func albie_speaking():
	miniA.stop()
	miniB.stop()
	if chA.animation == "Albie": 
		quick_tween(circleA)
		miniA.play()
	elif chB.animation == "Albie":
		quick_tween(circleB)
		miniB.play()

func mira_speaking():
	miniA.stop()
	miniB.stop()
	if chA.animation == "Mira": 
		quick_tween(circleA)
		miniA.play()
	elif chB.animation == "Mira":
		quick_tween(circleB)
		miniB.play()
	
func amaro_speaking():
	miniA.stop()
	miniB.stop()
	if chA.animation == "Amaro": 
		quick_tween(circleA)
		miniA.play()
	elif chB.animation == "Amaro":
		quick_tween(circleB)
		miniB.play()

func felicity_speaking():
	miniA.stop()
	miniB.stop()
	if chA.animation == "Felicity": 
		quick_tween(circleA)
		miniA.play()
	elif chB.animation == "Felicity":
		quick_tween(circleB)
		miniB.play()

func micah_speaking():
	miniA.stop()
	miniB.stop()
	if chA.animation == "Micah": 
		quick_tween(circleA)
		miniA.play()
	elif chB.animation == "Micah":
		quick_tween(circleB)
		miniB.play()

func beatrice_speaking():
	miniA.stop()
	miniB.stop()
	if chA.animation == "Beatrice": 
		quick_tween(circleA)
		miniA.play()
	elif chB.animation == "Beatrice":
		quick_tween(circleB)
		miniB.play()

func basil_speaking():
	miniA.stop()
	miniB.stop()
	if chA.animation == "Basil": 
		quick_tween(circleA)
		miniA.play()
	elif chB.animation == "Basil":
		quick_tween(circleB)
		miniB.play()

func quick_tween(node):
	node.position.y -= 40
	await get_tree().create_timer(0.3).timeout
	node.position.y += 40
	
func dialogue_go(dialogue_key):
	DialogueManager.dialogue_player(dialogue_key)
