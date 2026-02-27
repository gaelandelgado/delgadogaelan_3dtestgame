extends Node3D

@export var orb_color: Color = Color(1.0, 0.6, 0.1)
@export var orb_size: float = 1.0
@export var glow_intensity: float = 1.5

@onready var mesh_instance = $orb/pSphere1
@onready var light = $OmniLight3D
@onready var particles = $GPUParticles3D

var spin_speed: float = 1.0
var base_y: float = 0.0
var bob_speed: float = 3
var bob_height: float = 0.1

func _ready():
	base_y = position.y
	# Scale the whole orb — base mesh always stays at 1m
	scale = Vector3.ONE * orb_size

	# Push color and intensity into the glow shader
	var mat = mesh_instance.get_active_material(0)
	mat.set_shader_parameter("orb_color", Vector3(orb_color.r, orb_color.g, orb_color.b))
	mat.set_shader_parameter("glow_intensity", glow_intensity)

	# Match the point light to the orb color
	light.light_color = orb_color
	light.light_energy = glow_intensity * 0.6

	# Tint the particles to match
	var particle_mat = particles.process_material
	particle_mat.color = orb_color
	
	
func _process(delta):
	position.y = base_y + sin(Time.get_ticks_msec() / 1000.0 * bob_speed) * bob_height
	rotate_y(spin_speed * delta)
