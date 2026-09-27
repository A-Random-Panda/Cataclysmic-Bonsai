extends Node2D

var time = 0.0
var times_up = false
var score = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if times_up == false:
		if Input.is_action_just_pressed("stretch"):
			get_node("Gnome").scale.y += 0.1
			get_node("Image").position.y -=0.2*32
			score += 1
		
		time += delta
		if time > 10:
			times_up = true
			finish_game()
func finish_game():
	var player = get_tree().current_scene.get_node("Player")
	player.held_thing.emit_signal("task_finished",["Sun",score])
	player.in_game = false
	player.position = Vector2(832.0,493.0)
	self.queue_free()
	

	
