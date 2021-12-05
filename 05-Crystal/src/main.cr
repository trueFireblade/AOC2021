input = File.read("./input.txt").split "\n"
mapedInput = ((input.map &.split(" -> ")).map &.map(&.split ","))
# delete this if it causes issues:
_ = mapedInput.pop

mapedInput = mapedInput.map &.map(&.map &.to_i)

grid_size = 1024

grid1 = [] of Array(Int32)
grid2 = [] of Array(Int32)
i = 0
while i < grid_size
    j = 0
    subarr1 = [] of Int32
    subarr2 = [] of Int32
    while j < grid_size
	subarr1 << 0
        subarr2 << 0
	j += 1
    end
    grid1 << subarr1
    grid2 << subarr2
    i += 1
end

# insert values
mapedInput.each do |vent|
    zipedVent = vent[0].zip vent[1]
    xmin = zipedVent[0].min
    xmax = zipedVent[0].max
    ymin = zipedVent[1].min
    ymax = zipedVent[1].max
    if xmin == xmax || ymin == ymax
        xrange = xmin..xmax
        yrange = ymin..ymax
        xrange.each do |xc|
	    yrange.each do |yc|
	        grid1[xc][yc] += 1
		grid2[xc][yc] += 1
	    end
        end
    else
	xnew = vent[0][0]
	ynew = vent[0][1]
	xres = vent[1][0]
	yres = vent[1][1]
	grid2[xnew][ynew] += 1
	while xnew != xres
	    if xnew < xres
		xnew += 1
		if ynew < yres
		   ynew += 1
		   grid2[xnew][ynew] += 1
		else
		   ynew -= 1
		   grid2[xnew][ynew] += 1
		end
	    else
		xnew -= 1
		if ynew < yres
		   ynew += 1
		   grid2[xnew][ynew] += 1
		else
		   ynew -= 1
		   grid2[xnew][ynew] += 1
		end
	    end
	end
    end
end

# num of >= 2
res1 = 0
grid1.each do |row|
    row.each do |cell|
	if cell >= 2
	    res1 += 1
	end
    end
end

res2 = 0
grid2.each do |row|
    row.each do |cell|
	if cell >= 2
	    res2 += 1
	end
    end
end


puts "The result for part one is: #{res1}"
puts "The result for part two is: #{res2}"
