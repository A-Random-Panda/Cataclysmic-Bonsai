extends CharacterBody2D

@onready var tile_map_layer: TileMapLayer = get_tree().current_scene.get_node("TileMapLayer")
var speed = 150.0


func _physics_process(delta: float) -> void:
	var tile = get_tile()
	if tile == "road":
		speed = 150
		print('road')
	elif tile == "water":
		speed = 0
		print('cry')
	elif tile  == "grass":
		print('grass')
		speed = 20
	else:
		print("code does run")
	
	movement()
	move_and_slide()
	
func movement() -> void:
		# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("left","right","up","down")
	velocity = direction * speed
func play_animation(dir: Vector2) -> void:
	if dir.x > 0:
		pass
	elif dir.x < 0:
		pass

func get_tile():
	var player_pos = tile_map_layer.local_to_map(
		tile_map_layer.to_local(global_position)
	)
	var data = tile_map_layer.get_cell_tile_data(player_pos)
	if data:
		return data.get_custom_data("type")
	else:
		return "grass"
