asdf = [
"1224346384",
"5621128587",
"6388426546",
"1556247756",
"1451811573",
"1832388122",
"2748545647",
"2582877432",
"3185643871",
"2224876627",
]

# asdf= [
# "11111",
# "19991",
# "19191",
# "19991",
# "11111",
# ]

asdf = asdf.map{|row| row.split("").map(&:to_i)}

flashcount = 0
count = 0

315.times do
  count += 1
  puts asdf.map{|row| row.map{|e| e >= 10 ? "*": e.to_s}.join}
  puts "-------------------------------PLUS ONE"
  asdf = asdf.each{|row| row.map!{|e| e += 1}}
  puts asdf.map{|row| row.map{|e| e >= 10 ? "*": e.to_s}.join}

  flashed = []
  while true
    puts "================="
    puts asdf.map{|row| "  " + row.map{|e| e >= 10 ? "*": e.to_s}.join}
    flashables = []
    growables = []

    asdf.each_with_index do |row, r|
      row.each_with_index do |e, c|
        if e > 9
          flashables << [r, c]
          flashed << [r, c]
          flashcount += 1
          asdf[r][c] = 0
        end
      end
    end

    if flashables.empty?
      puts
      puts asdf.map{|row| "  " + row.map{|e| e >= 10 ? "*": e.to_s}.join}
      break
    end

    flashables.each do |flash|
      growables << [flash[0] - 1, flash[1] - 1]
      growables << [flash[0] - 1, flash[1]]
      growables << [flash[0] - 1, flash[1] + 1]
      growables << [flash[0], flash[1] - 1]
      growables << [flash[0], flash[1] + 1]
      growables << [flash[0] + 1, flash[1] - 1]
      growables << [flash[0] + 1, flash[1]]
      growables << [flash[0] + 1, flash[1] + 1]
    end

    growables.each do |grow|
      if grow[0] >= 0 && grow[0] < asdf.count
        if grow[1] >= 0 && grow[1] < asdf.first.count
          asdf[grow[0]][grow[1]] += 1
        end
      end
    end
    puts
    puts asdf.map{|row| "  " + row.map{|e| e >= 10 ? "*": e.to_s}.join}
  end

  flashed.each do |flash|
    asdf[flash[0]][flash[1]] = 0
  end
end
