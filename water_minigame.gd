extends Control

var points:int = 0
var speed:float = 300.0
var direction: float = 1
var timer: float = 0
@onready var bar: ColorRect = $Bar
@onready var marker: ColorRect = $Bar/Marker
@onready var target: ColorRect = $Bar/Target
@onready var result_label: Label = $Result
@onready var points_label: Label = $Points
@onready var ding: AudioStreamPlayer2D = $Ding
@onready var dong: AudioStreamPlayer2D = $Dong

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	if timer > 5 and timer < 10:
		speed = 400
	elif timer >= 10 and timer < 15:
		speed = 600
	elif timer >= 15:
		speed = 900
	marker.position.x += direction * speed * delta
	var max_pos := bar.size.x - marker.size.x
	if marker.position.x >= max_pos:
		direction = -1
	elif marker.position.x <= 0:
		direction = 1
	if Input.is_action_just_pressed("stretch"):
		check_timing()

func check_timing() -> void:
	if marker.position.x + marker.size.x >= target.position.x and marker.position.x <= target.position.x + target.size.x:
		result_label.text = "watered!"
		points += 1
		points_label.text = ("Current Points:" + str(points))
		ding.play()
	else:
		result_label.text = "missed!"
		points -= 1
		points_label.text = ("Current Points:" + str(points))
		dong.play()
		
