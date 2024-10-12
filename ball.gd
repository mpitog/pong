extends Area2D
class_name Ball

var speed = 300
var velocity : Vector2 = Vector2(0,0)
var start_dir : Vector2
var direction : Vector2
@onready var ball_effects: CPUParticles2D = $CPUParticles2D
@onready var game_over: Control = $"../Game_over"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	rotation = randf_range(deg_to_rad(-25),deg_to_rad(25))
	var start_dir_rng = randi_range(1,2)
	if start_dir_rng == 1:
		start_dir = Vector2.LEFT
	elif start_dir_rng == 2:
		start_dir = Vector2.RIGHT

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	direction = start_dir.rotated(global_rotation)
	var rand_speed_accel = randi_range(5,15)
	speed += delta * rand_speed_accel
	position += speed * direction * delta
	if scale == Vector2(1.0,1.0):
		var _timer = get_tree().create_timer(2).timeout
		var random_scale = randf_range(0.25,2.5)
		scale = Vector2(random_scale,random_scale)
		await get_tree().create_timer(2).timeout
		scale = Vector2(1.0,1.0)
	#print(velocity.x)
	#print(direction)

func _on_body_entered_player(body: Node2D) -> void:
	if  body.is_in_group("player"):
		if start_dir == Vector2.LEFT:
			start_dir = Vector2.RIGHT
			rotation = -rotation 
			ball_effects.emitting = true
		elif start_dir == Vector2.RIGHT:
			start_dir = Vector2.LEFT
			rotation = -rotation
			ball_effects.emitting = true

func _on_body_entered_enemy(body: Node2D) -> void:
	if  body.is_in_group("enemy"):
		if start_dir == Vector2.LEFT:
			start_dir = Vector2.RIGHT
			rotation = -rotation 
			ball_effects.emitting = true
		elif start_dir == Vector2.RIGHT:
			start_dir = Vector2.LEFT
			rotation = -rotation 
			ball_effects.emitting = true

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("margin"):
		if start_dir == Vector2.LEFT:
			rotation = -rotation
		elif start_dir == Vector2.RIGHT:
			rotation = -rotation

func _on_body_entered_sides(body: Node2D) -> void:
	if body.is_in_group("sides"):
		get_tree().paused = true
		game_over.visible = true
		
