extends Node2D

@onready var ball: Ball = $Ball
@onready var portal: Node2D = $Portal
var is_portal_visible = false

@onready var portal_a: Area2D = $Portal/PortalA
@onready var portal_b: Area2D = $Portal/PortalB

@onready var color_rect: ColorRect = $Control/ColorRect
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var shader_material: ShaderMaterial = color_rect.material
	var current_time = shader_material.get_shader_parameter("time")
	current_time += delta
	shader_material.set_shader_parameter("time", current_time)

#random position of the portal
func portal_position() -> void:
	is_portal_visible = true
	portal.visible = true
	print(portal_a,portal_b)
	portal_a.position = Vector2(randf_range(100,450),randf_range(40,600))
	portal_b.position = Vector2(randf_range(550,1050),randf_range(40,600))
	print(portal_a.position)

#make portal appear
func _on_timer_timeout() -> void:
	portal_position() 


#when ball enters portal a will reappear in portab b and vice versa
func _on_portal_a_area_entered(area: Area2D) -> void:
	if area.is_in_group('ball'):
		ball.position = portal_b.position
		#if ball.direction == Vector2.RIGHT:
			#ball.direction = Vector2.LEFT
			#ball.velocity.x = -ball.velocity.x
		#elif ball.direction == Vector2.LEFT:
			#ball.direction = Vector2.RIGHT
			#ball.velocity.x = -ball.velocity.x

func _on_portal_b_area_exited(area: Area2D) -> void:
	ball.rotation = ball.rotation + deg_to_rad(randf_range(15,25))


#func _on_portal_b_area_entered(area: Area2D) -> void:
	#if area.is_in_group('ball'):
		#ball.position = portal_a.position
		##if ball.direction == Vector2.RIGHT:
			##ball.direction = Vector2.LEFT
			##ball.velocity.x = -ball.velocity.x
		##elif ball.direction == Vector2.LEFT:
			##ball.direction = Vector2.RIGHT
			##ball.velocity.x = -ball.velocity.x
#
#
#func _on_portal_a_area_exited(area: Area2D) -> void:
	#ball.rotation = ball.rotation + deg_to_rad(randf_range(15,25))
#

#restart game
func _on_play_again_pressed() -> void:
	get_tree().reload_current_scene()
