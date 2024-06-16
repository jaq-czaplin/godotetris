class_name Explosion extends CPUParticles2D

func _ready():
	emitting = true
	finished.connect(on_finished);
	
func on_finished():
	queue_free()
	pass
