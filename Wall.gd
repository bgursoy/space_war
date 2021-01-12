extends Node2D

func _ready():
	pass

func _on_Horizontal_body_entered(body):
	body.velocity = body.velocity.reflect(Vector2(1,0))

func _on_Vertical_body_entered(body):
	body.velocity = body.velocity.reflect(Vector2(0,1))

func _on_Horizontal_area_entered(area):
	area.reflect(Vector2(1,0))

func _on_Vertical_area_entered(area):
	area.reflect(Vector2(0,1))
