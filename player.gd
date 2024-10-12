extends CharacterBody2D

const SPEED = 400.0
func _physics_process(_delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_up", "ui_down")
	if direction:
		velocity.y = direction * SPEED
		velocity.x = 0
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		velocity.x = 0

	move_and_slide()
