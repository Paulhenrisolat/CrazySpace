local MathManager = {}

-- Returns the distance between two points.
function MathManager.dist(x1,y1, x2,y2) 
    return ((x2-x1)^2+(y2-y1)^2)^0.5 
end

-- Returns the angle between two vectors assuming the same origin.
function MathManager.angle(x1,y1, x2,y2) 
    return math.atan2(y2-y1, x2-x1) 
end

-- If the distance of one object to the other is less than the sum of their radius(s) return true
function MathManager.checkCircularCollision(ax, ay, bx, by, ar, br)
	local dx = bx - ax
	local dy = by - ay
	local dist = math.sqrt(dx * dx + dy * dy)
	return dist < ar + br
end

return MathManager