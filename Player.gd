extends KinematicBody2D

const BULLET = preload("res://Bullet.tscn")
export (Vector2) var spawn_point
export (String) var player_name
var hud
var velocity = Vector2()
var angle = 0
var score = 0
var fuel = 500
var ammo = 10
var fired = 0
var is_dead = false

func _ready():
	$Gas1.hide()
	$Gas2.hide()

func _process(delta):
	self.position += velocity 

func fire():
	
	print("IsDead: "+ str(self.is_dead) + " Ammo: " + str(self.ammo) + " Fired: " + str(self.fired))
	#If user not able to fire, return
	if self.is_dead or self.ammo <= 0 or self.fired > 1:
		print("Out of ammo") 
		return
	#Fire bullet
	$FireSFX.play()
	var bullet = BULLET.instance()
	bullet.start(self, $Gun.global_position, Vector2(0, -1).rotated(deg2rad(self.angle)))
	get_parent().add_child(bullet)
	self.ammo -= 1
	self.fired += 1
	self.hud.set_ammo(self.ammo)

func rotate_left():
	#If user dead, do not rotate
	if self.is_dead: return
	#Rotate 5 degress
	self.angle = int(self.rotation_degrees + 360) % 360
	rotate(deg2rad(-5))

func rotate_right():
	#If user dead, do not rotate
	if self.is_dead: return
	#Rotate 5 degress
	self.angle = int(self.rotation_degrees + 360) % 360
	rotate(deg2rad(5))

func push_start():
	#Accelerate if there is fuel
	if fuel <= 0 or self.is_dead: 
		push_end() # Stop gas effect
		return
	#Increase velocity
	self.velocity += - Vector2(0, 0.03).rotated(deg2rad(self.angle))
	self.fuel -= 1 
	$Gas1.show()
	$Gas2.show()
	hud.set_fuel(self.fuel)

func push_end():
	#Hide gas sprite
	$Gas1.hide()
	$Gas2.hide()

func inc_score(value):
	self.score += 1
	self.hud.set_score(self.score)
	if self.score >= 10:
		get_parent().win(self)
	
	
func die():
	self.is_dead = true
	self.velocity = Vector2(0, 0)
	$Sprite.hide()
	$Gas1.hide()
	$Gas2.hide()
	$Animated.show()
	$Animated.play("die")
	$ExplosionSFX.play()

func lock():
	self.velocity = Vector2(0, 0)
	self.is_dead = true

func spawn():
	self.position = self.spawn_point
	self.angle = 0
	self.rotation_degrees = 0
	self.is_dead = false
	self.ammo = 10
	self.fuel = 500
	self.hud.set_fuel(self.fuel)
	self.hud.set_ammo(self.ammo)
	$Sprite.show()
	$Animated.hide()
	$Animated.stop()
	$Animated.frame = 0
