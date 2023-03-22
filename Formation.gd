extends KinematicBody2D

export (int) var speed = 200

onready var target = position
var velocity = Vector2()

func _input(event):
	if event.is_action_pressed("right_click"):
		target = get_global_mouse_position()

func _physics_process(__delta):
	velocity = position.direction_to(target) * speed
	look_at(get_global_mouse_position())
	if position.distance_to(target) > 5:
		velocity = move_and_slide(velocity)
