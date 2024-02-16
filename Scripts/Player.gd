extends CharacterBody2D

var speed : int
var jumpforce : int
var motion : Vector2

const levelCount = 2
const grav = 1
const maxFall = 400
const deltaMultiplier = 1000

var win : bool = false
var dead : bool = false

var fruits : int = 0
var fruitsTotal : int

@onready var ui = get_parent().get_node("InGameUI")
@onready var animState = $AnimationTree["parameters/playback"]

func _ready():
	speed = 10
	jumpforce = 22
	
	$AnimationTree.active = 1
	
	if ui:
		fruitsTotal = get_tree().get_nodes_in_group("FruitGang").size()
		ui.label.text = "Fruits: %d / %d" %[fruits, fruitsTotal]
	
	$Sprite2D.visible = 1
	$Death.visible = 0

func AddFruit():
	$"Sfx-Collect".play()
	if (win == false):
		fruits = fruits +1
		if ui:
			ui.label.text = "Fruits: %d / %d" %[fruits, fruitsTotal]

func RestartLevel():
	get_tree().reload_current_scene()

func PlayDeath():
	$Death.play("default")

func GoDie():
	if (dead == false):
		$"Sfx-Die".play()
		PauseMenu.PlayerDied()
		animState.travel("Die")
		dead = true
		if $RespawnTimer.is_stopped():
			$RespawnTimer.start()

func _on_respawn_timer_timeout():
	if (win == false):
		RestartLevel()

func Win():
	$"Sfx-Win".play()
	if (win == false):
		PauseMenu.PlayerWon(fruits)
		win = true
		if $LoadTimer.is_stopped():
			$LoadTimer.start()

func _on_load_timer_timeout():
	var level = int(get_tree().current_scene.name.substr(6,1)) + 1
	if (level > levelCount):
		PauseMenu.AddRecord()
		level = 0
	get_tree().change_scene_to_file("res://Scenes/Level-"+str(level)+".tscn")

func _physics_process(delta):

	if (dead == false):
	
	# MOVEMENT
		var dirX : float = Input.get_axis("Left", "Right")
		motion.x = dirX * (speed * deltaMultiplier) * delta
		
		if (is_on_ceiling()):
			motion.y = 0
		
		if (!is_on_floor()):
			motion.y += (grav * deltaMultiplier) * delta
			if (motion.y > maxFall):
				motion.y = maxFall
		else:
			motion.y = 0
			if (Input.is_action_just_pressed("Jump")):
				$"Sfx-Jump".play()
				motion.y = (-jumpforce * deltaMultiplier) * delta
		
		velocity = motion
		move_and_slide()
	
	# ANIMATION
		if (dirX > 0):
			$Sprite2D.scale.x = 1
		elif (dirX < 0):
			$Sprite2D.scale.x = -1
		
		if (is_on_floor()):
			if (dirX == 0):
				animState.travel("Idle")
			else:
				animState.travel("Jog")
		else:
			if (motion.y < 0):
				animState.travel("Jump")
			else:
				animState.travel("Fall")
	
	# INPUTS
	#	if (Input.is_action_just_pressed("Interact")):
	#		# set PauseMenu.checkpoint
	#		PauseMenu.checkpoint = position
	#	
	#	if (Input.is_action_just_pressed("InteractAlt")):
	#		# teleport to PauseMenu.checkpoint
	#		position = PauseMenu.checkpoint
