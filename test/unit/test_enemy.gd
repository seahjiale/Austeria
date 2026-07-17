extends GutTest

var EnemyScript = preload("res://Assets/Game/enemy.gd")

class TestableEnemy extends "res://Assets/Game/enemy.gd":
	func die():
		is_dead = true

var enemy

func before_each():
	enemy = TestableEnemy.new()
	enemy.health = 3
	enemy.xp_reward = 10
	ExpManager.reset()

func after_each():
	enemy.free()

func test_non_lethal_hit_while_already_taking_damage():
	enemy.is_taking_damage = true
	enemy.take_damage(1)
	assert_eq(enemy.health, 2, "Health should drop by the damage amount")
	assert_false(enemy.is_dead, "Should not be dead yet")

func test_lethal_hit_while_already_taking_damage():
	enemy.is_taking_damage = true
	enemy.take_damage(5)
	assert_true(enemy.is_dead, "Should die once health drops to 0 or below")

func test_lethal_hit_from_full_health():
	enemy.take_damage(5)
	assert_true(enemy.is_dead, "A lethal single hit should kill the enemy")
	assert_true(enemy.health <= 0, "Health should be 0 or below after a lethal hit")

func test_dead_enemy_ignores_further_damage():
	enemy.is_dead = true
	enemy.health = 3
	enemy.take_damage(5)
	assert_eq(enemy.health, 3, "A dead enemy should not take further damage")

func test_death_grants_xp_reward():
	enemy.xp_reward = 25
	enemy.take_damage(5)
	assert_eq(ExpManager.current_xp, 25, "Killing the enemy should grant its xp_reward to ExpManager")

func test_death_grants_xp_even_mid_animation():
	enemy.is_taking_damage = true
	enemy.xp_reward = 15
	enemy.take_damage(5)
	assert_eq(ExpManager.current_xp, 15, "XP should be granted on lethal hit regardless of animation state")
