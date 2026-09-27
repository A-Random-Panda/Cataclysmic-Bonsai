extends Node2D
@export var corner_1: Vector2 = Vector2(50,50)
@export var corner_2: Vector2 = Vector2(1100,600)
@onready var notes_animation: PackedScene = preload("res://music minigame/notes.tscn")
var timer: float = 0
var notes_list: Array = []
var score: int = 0
var animation_timer: float = 0
var audio_list: Array = []
var audio_index: int = 0

func random_spawnpoint(p1: Vector2, p2:Vector2) -> Vector2:
	var x_value: float = randf_range(p1.x,p2.x)
	var y_value: float = randf_range(p1.y,p2.y)
	var random_point: Vector2 = Vector2(x_value, y_value)
	return(random_point)
# Called when the node enters the scene tree for the first time. 
func _ready() -> void:
	audio_list = [$C1, $D, $E, $F, $G, $A, $B, $C2]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	animation_timer += delta
	if (timer > 1 and animation_timer < 5 ) or (timer > 0.7 and animation_timer >= 5 and animation_timer < 13) or (timer > 0.5 and animation_timer >= 13 and animation_timer < 20):
		spawn_notes()
		timer = 0
	if len(notes_list) > 0 :
		for i in notes_list:
			var animated_sprite: AnimatedSprite2D = i.get_node("AnimatedSprite2D")
			if not animated_sprite.is_playing():
				score -= 1
				$Label.text = ("Curent score " + str(score))
				notes_list.erase(i)
				i.queue_free()
			if animation_timer > 5:
				animated_sprite.sprite_frames.set_animation_speed("default",5)
			if animation_timer > 15:
				animated_sprite.sprite_frames.set_animation_speed("default",8)

func _on_mouse_entered(note: Node2D) -> void:
	score += 1
	if audio_index == 8:
		audio_index = 0
	audio_list[audio_index].play()
	audio_index += 1
	$Label.text = ("Curent score " + str(score))
	notes_list.erase(note)
	note.queue_free()



func spawn_notes() -> void:
	var notes: Node = notes_animation.instantiate()
	add_child(notes)	
	var spawn_location: Vector2 = random_spawnpoint(corner_1, corner_2)
	notes.set_position(spawn_location)
	notes_list.append(notes)
	var area2d: Area2D = notes.get_node("AnimatedSprite2D/Area2D")
	area2d.mouse_entered.connect(_on_mouse_entered.bind(notes))
