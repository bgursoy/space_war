extends Node2D

export (bool) var shown

func _ready():
	if shown:
		self.show()
	else:
		self.hide()

func set_fuel(fuel):
	$FuelBar.value = int(fuel / 5)

func set_ammo(ammo):
	$AmmoValueLabel.text = str(ammo)

func set_score(score):
	$ScoreLabel.text = str(score)
	
