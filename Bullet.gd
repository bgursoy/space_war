extends Area2D

var speed = 10
var bounced = 0

var player
var direction
var velocity

func _ready():
	pass
	
func _process(delta):
	self.position += (velocity)

func start(player, position, direction):
	self.player = player
	self.position = position 
	self.velocity = player.velocity + (direction * speed)

func reflect(normal):
	self.velocity = self.velocity.reflect(normal) 
	bounced += 1
	if bounced == 2:
		#clear bullet
		if self.player.fired > 0:
			self.player.fired -= 1
		if self.visible:
			queue_free()

func _on_Bullet_body_entered(body):
	# body: hitten player, self.player: owner of bullet
	self.hide()
	$CollisionShape2D.disabled
	self.player.fired = 0
	
	if (!body.is_dead):
		# Increment score only if bullet hit the opponent
		for p in get_parent().players:
			p.lock()
			if (p != body):
				p.inc_score(1)
	body.die()
	body.get_node("CollisionShape2D").disabled
	
	# Wait
	yield(get_tree().create_timer(1.0), "timeout")
	
	for p in get_parent().players:
		p.spawn()
	
	self.queue_free()
