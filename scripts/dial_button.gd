extends Button



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	self.rotation_degrees += 1.3

func _on_mouse_entered() -> void:
	print("mouse entered")
	self.scale = Vector2(0.55,0.55)


func _on_mouse_exited() -> void:
	print("mouse exited")
	self.scale = Vector2(0.5,0.5)
