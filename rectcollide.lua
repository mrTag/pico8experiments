spd=50
lasttime=time()
rect1 = {
	x=10,
	y=10,
	sx=20,
	sy=20
}
rect2 = {
	x=50,
	y=50,
	sx=20,
	sy=20
}
coll={false,0,0}

function drawrect(r,c)
	line(r.x,r.y,r.x+r.sx,r.y,c)
	line(r.x+r.sx,r.y,r.x+r.sx,r.y+r.sy,c)
	line(r.x+r.sx,r.y+r.sy,r.x,r.y+r.sy,c)
	line(r.x,r.y+r.sy,r.x,r.y,c)
end

function _draw()
	cls()
	if coll.overlap then c=8
	else c=11 end
	drawrect(rect1,c)
	drawrect(rect2,c)
	print(coll.xnorm..","..coll.ynorm,0,0)
end

function rectcollide(r1,r2)
	-- calculate how much each point overlaps the other edge
	-- this is best visualized, x and y overlap seperately!
	local xovr1=(r1.x+r1.sx)-r2.x
	local xovr2=(r2.x+r2.sx)-r1.x
	local yovr1=(r1.y+r1.sy)-r2.y
	local yovr2=(r2.y+r2.sy)-r1.y

	-- take the smaller of the two horizontal overlaps as the normal
	local xnorm=-xovr1
	if xovr2<xovr1 then
		xnorm=xovr2
	end

	-- same for the vertical overlap
	local ynorm=-yovr1
	if yovr2<yovr1 then
		ynorm=yovr2
	end

	return {
		-- the rectangles only overlap if all of the points
		-- overlaps the other edge positively!
		overlap=min(xovr1,xovr2)>0 and min(yovr1,yovr2)>0,
		xnorm=xnorm,
		ynorm=ynorm
	}
end

function _update()
	local dt=time()-lasttime
	lasttime=time()

	-- both rects are moveable!
	if (btn(0,0)) rect1.x-=spd*dt
	if (btn(1,0)) rect1.x+=spd*dt
	if (btn(2,0)) rect1.y-=spd*dt
	if (btn(3,0)) rect1.y+=spd*dt

	if (btn(0,1)) rect2.x-=spd*dt
	if (btn(1,1)) rect2.x+=spd*dt
	if (btn(2,1)) rect2.y-=spd*dt
	if (btn(3,1)) rect2.y+=spd*dt

	-- saves the collision in the global variable coll
	coll=rectcollide(rect1,rect2)

	-- collision response: simply moves rect1
	-- out of the collision by the normal
	if coll.overlap then
		-- only the smaller axis gets resolved here
		-- the beauty of axis aligned 'physics' :)
		if abs(coll.xnorm) < abs(coll.ynorm) then
			rect1.x += coll.xnorm
		else
			rect1.y += coll.ynorm
		end
	end
end