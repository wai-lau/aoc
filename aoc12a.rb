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


def try_next(start_node, nodehash, nodes_visited, doublespent)
  answers ||= []
  nodes_visited << start_node

  # puts nodes_visited.join("-")
  return nodes_visited.join("-") if start_node == "end"

  choices = nodehash[start_node] - nodes_visited.select{|e| e == e.downcase}
  unless doublespent
    choices << "*"
  end

  return if choices.empty?
  
  # choices.each do |c|
    # puts "  "+c
  # end

  choices.each do |choice|

    # puts "GO TO #{choice}"
    if choice == "*"
      doublespent = true

      choices2 = nodehash[start_node]
      choices2.each do |choice2|
        # puts "GO TO #{choice2}"
        answer = try_next(choice2, nodehash, nodes_visited.clone, doublespent)
        if answer.nil?
          # puts "backtrack"
          next
        end
        if answer.is_a? String
          answers << answer
        elsif answer.is_a? Array
          answers = answers + answer
        end
      end

    else
      answer = try_next(choice, nodehash, nodes_visited.clone, doublespent)
      if answer.nil?
        # puts "backtrack"
        next
      end
      if answer.is_a? String
        answers << answer
      elsif answer.is_a? Array
        answers = answers + answer
      end
    end
  end
  return answers
end

puts "GO TO start"
puts try_next("start", asdf4, [], false).uniq.count

require 'pry'; binding.pry
puts
