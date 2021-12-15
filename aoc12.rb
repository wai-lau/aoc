require 'json'
# asdf =  %w(dc-end HN-start start-kj dc-start dc-HN LN-dc HN-end kj-sa kj-HN kj-dc)
# asdf = %w(fs-end he-DX fs-he start-DX pj-DX end-zg zg-sl zg-pj pj-he RW-he fs-DX pj-RW zg-RW start-pj he-WI zg-he pj-fs start-RW)
asdf = %w(LP-cb PK-yk bf-end PK-my end-cb BN-yk cd-yk cb-lj yk-bf bf-lj BN-bf PK-cb end-BN my-start LP-yk PK-bf my-BN start-PK yk-EP lj-BN lj-start my-lj bf-LP)
# asdf = %w(start-A start-b A-c A-b b-d A-end b-end)

asdf2 = asdf.map{|e| e.split("-")}
asdf3 = asdf.map{|e| e.split("-").reverse}

asdf4 = {}

asdf2.each do |e|
  asdf4[e[0]] ||= []
  asdf4[e[0]] << e[1]
end

asdf3.each do |e|
  asdf4[e[0]] ||= []
  asdf4[e[0]] << e[1]
end

asdf4.keys.each do |key|
  asdf4[key] = asdf4[key].select {|e| e != 'start'}
end

asdf5 = JSON.parse(asdf4.to_json)
# asdf5["yk"] = asdf5["yk"] - ["EP", "cd"]

def travel_randomly(start_node, nodehash, doublecave, nodes_visited = [])
  if doublecave.nil? || start_node != doublecave
    nodes_visited << start_node
  else
    nodes_visited << (doublecave + "2")
    doublecave = nil
  end

  return nodes_visited if start_node == "end"
  remaining_choices = nodehash[start_node].clone - nodes_visited.select{|e|e == e.downcase}

  if doublecave && nodehash[start_node].include?(doublecave)
    remaining_choices << doublecave
  end

  # puts "VIS: " + nodes_visited.join("-")
  # puts "OPTS: " + remaining_choices.join("-")

  return nodes_visited if remaining_choices.count == 0

  choice = remaining_choices[rand(remaining_choices.count)]
  # puts "GO TO: #{choice}"
  # puts

  travel_randomly(choice, nodehash, doublecave, nodes_visited)
end

doublecaves = asdf4.keys.select{|k| k == k.downcase}.select{|k| k != 'end'}.select{|k| k != 'start'}

paths = []
attempts = 0
randomo = 0

10000.times do
  100000.times do
    doublecave = doublecaves[attempts % doublecaves.count]
    if attempts % doublecaves.count == 0
      randomo += 1
    end

    doublecavetwo = (doublecave + "2")
    attempts += 1
    srand(randomo)

    paths << travel_randomly("start", (doublecave == "yk" ? asdf4 : asdf5), doublecave).map{|e| e == doublecavetwo ? e[0...-1] : e}
  end
  paths = paths.uniq
  puts "#{attempts}   #{paths.select{|p|p.include?('end')}.count}"
end

require 'pry'; binding.pry
puts
