extends CharacterBody3D

@export var speed : int = 14
@export var fall_accel : int = 75

var target_vel : Vector3 = Vector3.ZERO

func _physics_process(delta):
	# We create a local variable to store the input direction.
	var direction = Vector3.ZERO

	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		# Notice how we are working with the vector's x and z axes.
		# In 3D, the XZ plane is the ground plane.
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.basis = Basis.looking_at(direction)

	target_vel.x = direction.x * speed
	target_vel.z = direction.y * speed
	
	if not is_on_floor():
		target_vel.y -= (fall_accel * delta)
	
	velocity = target_vel
	move_and_slide()
