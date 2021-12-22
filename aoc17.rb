minx = 209
maxx = 238
miny=-86
maxy=-59
# minx = 20
# maxx = 30
# miny=-10
# maxy=-5

possible_vx = []

(maxx+2).times do |i|
  x = 0
  hits = []
  vx = i
  steps = 0

  while true
    x += vx
    steps += 1
    vx -= 1 if vx > 0
    break if steps >= maxx*2
    break if x > maxx

    if x >= minx && x <= maxx
      hits << steps
    end
  end
  if !hits.empty?
    possible_vx << [i, hits.last]
  end
end

# possible_vx = possible_vx.sort_by{|e| e[1]}.reverse
possible_vx = possible_vx.map{|e|e[0]}

max_drop = ((maxx+2)/2)*maxx

possible_vy = []

[*miny..max_drop].each do |i|
  y = 0
  vy = i

  never = false
  while true
    y += vy
    vy -= 1

    if y >= max_drop
      never = true
      break
    end

    if y < miny
      break
    end

    if y >= miny && y <= maxy
      possible_vy << i
      break
    end
  end

  break if never
end

hits = []

possible_vx.each do |vxi|
  possible_vy.each do |vyi|
    x = 0
    y = 0
    vx = vxi
    vy = vyi

    while true
      x += vx
      y += vy

      vx -= 1 if vx > 0
      vy -= 1

      break if x > maxx
      break if y < miny

      if x >= minx && x <= maxx && y >= miny && y <= maxy
        hits << [vxi, vyi]
      end
    end
  end
end

require 'pry'; binding.pry
puts
