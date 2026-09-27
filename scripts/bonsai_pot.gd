extends Node2D
@export var h_meter:float = 200
@export var water_game:PackedScene
@export var music_game:PackedScene
@export var forest_game:PackedScene
signal task_finished(finished:bool)

@onready var tasks = task.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	h_meter -= delta
	tasks.assign(get_node("Label"))
func _on_task_finished(finished:bool) -> void:
	if h_meter + 50 < 200:
		h_meter += 50
	else:
		scale.x +=  h_meter+50-200
		scale.y +=  h_meter+50-200
		h_meter = 200
		
