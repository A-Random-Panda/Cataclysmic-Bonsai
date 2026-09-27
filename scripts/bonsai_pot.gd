extends Node2D
class_name Bonsai_Pot
	
@export var h_meter:float = 200
@export var water_game:PackedScene
@export var music_game:PackedScene
@export var forest_game:PackedScene
signal task_finished(task_type:String,reward:int)
signal is_grabbed(pos:Vector2)
var grabbed
var tasks = task.new()
var dead:bool = false
func _ready():
	tasks.assign(get_node("Label"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not dead:
		h_meter -= delta
		if h_meter < 0:
			get_node("Label").text = "I hath withered"
			dead = true
		if grabbed:
			position.x = get_tree().current_scene.get_node("Player").position.x
			position.y = get_tree().current_scene.get_node("Player").position.y - 62
		
func _on_task_finished(args) -> void:
	var task_type = args[0]
	var reward = args[1] 
	if not dead:
		if reward == -1:reward = 50
		if task_type == tasks.curr_task:
			if h_meter + reward < 200:
				h_meter += reward
			else:
				scale.x +=  (h_meter+reward-200)/1000
				scale.y +=  (h_meter+reward-200)/1000
				h_meter = 200
				var size_label = get_node("SizeLabel")
				size_label.text = str(float(size_label.text) * (1+(h_meter+reward-200)/100))
			tasks.finish(get_node("Label"))
			

func _on_is_grabbed(pos:Vector2) -> void:
	if not dead:
		grabbed = true
