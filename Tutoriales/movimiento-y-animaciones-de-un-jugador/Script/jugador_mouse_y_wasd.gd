extends CharacterBody2D

# Palabras clave para personalizar
@export var VELOCIDAD := 100
var direccion := Vector2.ZERO
var destino_click := Vector2.ZERO
var usando_clic := false

func _physics_process(delta):
	movimiento()

func _process(delta):
	actualizar_animacion()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		destino_click = get_global_mouse_position()
		usando_clic = true

func movimiento():
	direccion = Vector2.ZERO #Para evitar movimiento infinito

	# Movimiento por teclado
	if Input.is_action_pressed("W"): direccion.y -= 0.5 #debido a que la panatalla no es cuadrada
	if Input.is_action_pressed("S"): direccion.y += 0.5
	if Input.is_action_pressed("A"): direccion.x -= 1
	if Input.is_action_pressed("D"): direccion.x += 1
	
	# Movimiento por clic
	if usando_clic:
		var hacia_destino := (destino_click - global_position).normalized()
		if global_position.distance_to(destino_click) > 5:
			direccion = hacia_destino
		else:
			usando_clic = false
	
	# Aplicar movimiento
	velocity = direccion.normalized() * VELOCIDAD
	move_and_slide()

func actualizar_animacion():
	var DireccionAnimacion = "Idle"
	
	if (direccion.x <= -0.5):
		DireccionAnimacion = "Izquierda"
	elif (direccion.x >= 0.5):
		DireccionAnimacion = "Derecha"
	elif (direccion.y >= 0.5):
		DireccionAnimacion = "Abajo"
	elif (direccion.y <= -0.5):
		DireccionAnimacion = "Arriba"
	
	get_node("AnimatedSprite2D").play(DireccionAnimacion)
