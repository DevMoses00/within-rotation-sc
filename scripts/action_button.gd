extends Button

@export_category("Gumballs + Shadow")
#@export var gumball1 : AnimatedSprite2D
#@export var g1shadow: AnimatedSprite2D
#@export var gumball2 : AnimatedSprite2D
#@export var g2shadow: AnimatedSprite2D
#@export var gumball3 : AnimatedSprite2D
#@export var g3shadow: AnimatedSprite2D
#@export var gumball4 : AnimatedSprite2D
#@export var g4shadow: AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.rotation_degrees += 1.3



func _on_mouse_entered() -> void:
	print("mouse entered")
	self.scale = Vector2(0.55,0.55)
	#SoundManager.play_sfx("Click1",0,-30,-100)
	#gumball1.rotation_degrees -= 20
	#gumball2.rotation_degrees -= 20
	#gumball3.rotation_degrees -= 20
	#gumball4.rotation_degrees -= 20
	#g1shadow.position.x -= 10
	#g2shadow.position.x -= 10
	#g3shadow.position.x -= 10
	#g4shadow.position.x -= 10


func _on_mouse_exited() -> void:
	print("mouse exited")
	self.scale = Vector2(0.5,0.5)
	#gumball1.rotation_degrees += 20
	#gumball2.rotation_degrees += 20
	#gumball3.rotation_degrees += 20
	#gumball4.rotation_degrees += 20
	#g1shadow.position.x += 10
	#g2shadow.position.x += 10
	#g3shadow.position.x += 10
	#g4shadow.position.x += 10
