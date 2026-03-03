extends StaticBody3D

var is_open: bool = false

@onready var animation_player = $AnimationPlayer
@onready var door_collision = $DoorCollision

func _on_door_trigger_body_entered(body: Node3D):
	if body.is_in_group("player") and not is_open:
		if body.has_key:
			open_door(body)
		else:
			print("The door is locked!")

func open_door(player: Node3D):
	is_open = true
	player.has_key = false
	animation_player.play("open")
