extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_mouse_entered() -> void:
	print("mouse entered")
	self.scale = Vector2(0.55,0.55)
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
