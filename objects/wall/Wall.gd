extends StaticBody2D

export(PoolVector2Array) var polygon

func _ready():
	$CollisionPolygon2D.polygon = polygon
	$CollisionPolygon2D/Polygon2D.polygon = polygon


