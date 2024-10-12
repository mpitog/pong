extends Node2D
class_name Enemy

const SPEED = 200.0
# Get the viewport si


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var ball: Ball = $"../../Ball"
var padding : float = 20.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var viewport_size = get_viewport().get_visible_rect().size
	var enemy_shape = collision_shape_2d.shape.size

	#print (enemy_shape)
	#print("Viewport size: ", viewport_size)
	if ball.position.y >  enemy_shape.y +padding and ball.position.y < viewport_size.y - enemy_shape.y-padding:
		position.y = move_toward(self.global_position.y, ball.global_position.y - 50,SPEED*delta)
		position.x = global_position.x
