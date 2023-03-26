extends CharacterBody2D

@export var speed = 400
var selected_texture = preload("res://images/formation_selected_blue.png")
var default_texture = preload("res://images/formation_blue.png")
@onready var sprite = get_node("AllyFormationSprite")
var target = position
var selectable = false
var selected = false

func _input(event):
	if selectable && event.is_action("right_click"):
		selected = true
		sprite.texture = selected_texture
	if event.is_action("right_click") && selected:
		look_at(get_global_mouse_position())
		target = get_global_mouse_position()
		
func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	look_at(target)
	if position.distance_to(target) > 10:
		move_and_slide()

func _mouse_enter():
	selectable = true
