extends Node2D
class_name Bonsai_Pot
	
@export var h_meter:float = 200
@export var water_game:PackedScene
@export var music_game:PackedScene
@export var forest_game:PackedScene
signal task_finished()
signal is_grabbed(pos:Vector2)
var grabbed
func _ready():
	var tasks = task.new()
	tasks.assign(get_node("Label"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	h_meter -= delta
	if h_meter < 0:
		get_node("Label").text = "I hath withered"
	if grabbed:
		position.x = get_tree().current_scene.get_node("Player").position.x
		position.y = get_tree().current_scene.get_node("Player").position.y - 70
func _on_task_finished() -> void:
	if h_meter + 50 < 200:
		h_meter += 50
	else:
		scale.x +=  (h_meter+50-200)/1000
		scale.y +=  (h_meter+50-200)/1000
		h_meter = 200

func _on_is_grabbed(pos:Vector2) -> void:
	grabbed = true
