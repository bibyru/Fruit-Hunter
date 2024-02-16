extends Node2D

@export var dot1 : Node2D
@export var dot2 : Node2D
@export var speed = 2

var dots
var index = 0
var limit = 0.1

func _ready():
	
	$Dot1/Sprite2D.visible = 0
	$Dot2/Sprite2D.visible = 0
	if dot1 && dot2:
		dots = [dot1.position, dot2.position]

func _physics_process(delta):
	
	if dot1 && dot2:
		var distance : Vector2 = abs(dots[index] - $Saw.position)
		if (distance.x <= limit && distance.y <= limit):
			index = index +1
			if (index >= 2):
				index = 0
		
		$Saw.position.x = move_toward($Saw.position.x, dots[index].x, speed)
		$Saw.position.y = move_toward($Saw.position.y, dots[index].y, speed)
