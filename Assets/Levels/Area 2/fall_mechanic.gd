extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("player")):
		get_tree().root.get_node("Area2/UI").hide()
		SceneTransition.transition_to(get_tree().current_scene.scene_file_path)
