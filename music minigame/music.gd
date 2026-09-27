extends Node2D
@export var corner_1: Vector2 = Vector2(50,50)
@export var corner_2: Vector2 = Vector2(1100,600)
@onready var notes_animation: PackedScene = preload("res://music minigame/notes.tscn")
var timer: float = 0
var notes_list: Array = []

func random_spawnpoint(p1: Vector2, p2:Vector2) -> Vector2:
	var x_value: float = randf_range(p1.x,p2.x)
	var y_value: float = randf_range(p1.y,p2.y)
	var random_point: Vector2 = Vector2(x_value, y_value)
	return(random_point)
# Called when the node enters the scene tree for the first time. 
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	if timer > 1:
		spawn_notes()
		print ("hi")
		timer = 0
	for i in notes_list:
		var animated_sprite: AnimatedSprite2D = i.get_node("AnimatedSprite2D")
		if not animated_sprite.is_playing():
			notes_list.erase(i)
			i.queue_free()
		
	

func spawn_notes() -> void:
	var notes: Node = notes_animation.instantiate()
	add_child(notes)	
	var spawn_location: Vector2 = random_spawnpoint(corner_1, corner_2)
	notes.set_position(spawn_location)
	notes_list.append(notes)
	 
