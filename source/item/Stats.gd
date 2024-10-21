class_name Stats

var health : float = 0
var topSpeed : float = 0
var attackSpeed : float = 0
var attackDamage : float = 0
var dashCooldown : float = 0
var abilityCooldown : float = 0
var cost : int = 0

func add_stats(s : Stats) :
	health += s.health
	topSpeed += s.topSpeed
	attackSpeed += s.attackSpeed
	attackDamage += s.attackDamage
	dashCooldown += s.dashCooldown
	abilityCooldown += s.abilityCooldown
	cost += s.cost

func subtract_stats(s : Stats) :
	health -= s.health
	topSpeed -= s.topSpeed
	attackSpeed -= s.attackSpeed
	attackDamage -= s.attackDamage
	dashCooldown -= s.dashCooldown
	abilityCooldown -= s.abilityCooldown
	cost -= s.cost

func copy() -> Stats :
	var s = Stats.new()
	s.health = health
	s.topSpeed = topSpeed
	s.attackSpeed = attackSpeed
	s.attackDamage = attackDamage
	s.dashCooldown = dashCooldown
	s.abilityCooldown = abilityCooldown
	s.cost = cost
	return s
