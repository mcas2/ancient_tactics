extends CharacterBody2D

@export var speed = 400
var selected_texture = preload("res://images/formation_selected_blue.png")
var rotable_texture = preload("res://images/formation_rotable_blue.png")
var default_texture = preload("res://images/formation_blue.png")
@onready var sprite = get_node("AllyFormationSprite")
var target = position
var selectable = false
var selected = false
var rotable = false

func _init():
	print("Click to select, Q to deselect, R to rotate")

func _input(event):
	if selectable && event.is_action("right_click"):
		selected = true
		sprite.texture = selected_texture
	if selected:
		if event.is_action("right_click") and !rotable:
			target = get_global_mouse_position()
		if event is InputEventKey and event.pressed and event.keycode == KEY_R:
			rotate_formation(event)
		if event is InputEventKey and event.pressed and event.keycode == KEY_Q:
			sprite.texture = default_texture
			selected = false
	if (rotable):
		sprite.texture = rotable_texture
		look_at(get_global_mouse_position())

func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) > 10:
		move_and_slide()

func _mouse_enter():
	selectable = true

func _mouse_exit():
	selectable = false

func rotate_formation(event):
	if (rotable):
		rotable = false
		sprite.texture = selected_texture
	else:
		rotable = true
