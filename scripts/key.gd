extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pickup_area_body_entered(body):
	if body.is_in_group("player"):
		body.has_key = true
		print("Key picked up!")  # replace this with a sound/effect later
		queue_free()  # removes the key from the scene
