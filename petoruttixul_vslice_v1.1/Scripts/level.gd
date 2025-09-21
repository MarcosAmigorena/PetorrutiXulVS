extends Node2D

var current_player: CharacterBody2D
@export var level_size: Vector2 = Vector2(2480, 720) # ancho x alto del "mundo"

func _ready() -> void:
	# activar Player1 al inicio
	$Player.is_active = true
	$Player_2.is_active = false
	current_player = $Player

	# cámara
	$Player/Camera2D.make_current()


	# conectar botón del HUD
	$HUD/SwitchButton.pressed.connect(_on_switch_button_pressed)


func _process(delta: float) -> void:
	# Cambiar con tecla TAB además del botón
	if Input.is_action_just_pressed("switch_character"):
		_toggle_player()

func _on_switch_button_pressed() -> void:
	_toggle_player()

func _toggle_player() -> void:
	if current_player == $Player:
		_switch_to($Player_2)
	else:
		_switch_to($Player)

func _switch_to(new_player: CharacterBody2D) -> void:
	current_player.is_active = false
	current_player = new_player
	current_player.is_active = true

	# cambiar cámara
	if current_player == $Player:
		$Player/Camera2D.make_current()
	else:
		$Player_2/Camera2D.make_current()
