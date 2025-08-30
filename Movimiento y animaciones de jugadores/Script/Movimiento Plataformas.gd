extends CharacterBody2D

@export var SPEED = 200.0
const JUMP_VELOCITY = -500.0
var direccion := Vector2.ZERO

func _process(delta: float) -> void:
	actualizar_animacion()

func _physics_process(delta: float) -> void:
	movimiento(delta)

func movimiento(delta):
	direccion = Vector2.ZERO #reiniciar para la animacion
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("A", "D")
	if direction:
		direccion.x = direction
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func actualizar_animacion():
	var DireccionAnimacion = "Idle"
	
	if (direccion.x <= -0.5):
		DireccionAnimacion = "Izquierda"
	elif (direccion.x >= 0.5):
		DireccionAnimacion = "Derecha"
	
	get_node("AnimatedSprite2D").play(DireccionAnimacion)
