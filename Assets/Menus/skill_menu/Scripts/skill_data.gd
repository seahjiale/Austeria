class_name SkillData
extends Resource

enum SkillType { ACTIVE, PASSIVE, SPELL }

@export var id: String
@export var name: String
@export var description: String
@export var icon: Texture2D
@export var type: SkillType
