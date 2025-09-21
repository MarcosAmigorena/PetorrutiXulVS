extends CharacterBody2D

@export var speed: float = 220.0
@export var accel: float = 1200.0
@export var deaccel: float = 1400.0

var is_active: bool = false

func _physics_process(delta: float) -> void:
	if not is_active:
		return

	# Activar cámara en el primer frame de movimiento
	$Camera2D.make_current()

	var input_dir := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var target_speed := input_dir * speed

	if abs(target_speed - velocity.x) < 1.0:
		velocity.x = target_speed
	else:
		if target_speed > velocity.x:
			velocity.x = min(velocity.x + accel * delta, target_speed)
		else:
			velocity.x = max(velocity.x - deaccel * delta, target_speed)

	velocity.y = 0.0
	move_and_slide()

	if input_dir < 0:
		$Sprite2D.scale.x = -1.0
	elif input_dir > 0:
		$Sprite2D.scale.x = 1.0
