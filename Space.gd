extends Node2D

var players = []

func _ready():
	players.append($Player1)
	players.append($Player2)

func _process(delta):
	$Player1.hud = $Hud.get_node("Hud1")
	$Player2.hud = $Hud.get_node("Hud2")
	
	#Key Bindings P1
	if Input.is_action_just_pressed("player1_fire"):
		$Player1.fire()
	
	if Input.is_action_pressed("player1_push"):
		$Player1.push_start()
	
	if Input.is_action_just_released("player1_push"):
		$Player1.push_end()
	
	if Input.is_action_pressed("player1_right"):
		$Player1.rotate_right()
	
	if Input.is_action_pressed("player1_left"): 
		$Player1.rotate_left()

	#Key Bindings P2
	if Input.is_action_just_pressed("player2_fire"):
		$Player2.fire()
	
	if Input.is_action_pressed("player2_push"):
		$Player2.push_start()
	
	if Input.is_action_just_released("player2_push"):
		$Player2.push_end()
	
	if Input.is_action_pressed("player2_right"):
		$Player2.rotate_right()
	
	if Input.is_action_pressed("player2_left"): 
		$Player2.rotate_left()

func win(player):
	print("Game Over")
