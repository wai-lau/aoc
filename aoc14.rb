rules = {
"BC" => "C",
"PP" => "O",
"SK" => "K",
"KH" => "N",
"OK" => "S",
"PC" => "O",
"VP" => "K",
"CF" => "K",
"HC" => "H",
"FV" => "V",
"PB" => "P",
"NK" => "H",
"CK" => "F",
"FH" => "H",
"SV" => "B",
"NH" => "C",
"CP" => "S",
"HP" => "O",
"HS" => "O",
"BK" => "B",
"KC" => "P",
"VV" => "B",
"OF" => "O",
"KP" => "V",
"FO" => "V",
"FK" => "V",
"VH" => "K",
"KB" => "P",
"KF" => "H",
"SH" => "S",
"HF" => "O",
"BB" => "F",
"FC" => "O",
"SO" => "S",
"BS" => "O",
"HH" => "C",
"BO" => "S",
"CO" => "F",
"VC" => "V",
"KS" => "N",
"OC" => "N",
"FP" => "P",
"HN" => "B",
"HV" => "V",
"HO" => "P",
"KO" => "C",
"SF" => "H",
"NO" => "N",
"PS" => "C",
"BP" => "K",
"SC" => "C",
"NP" => "C",
"CH" => "V",
"KV" => "B",
"HK" => "V",
"OP" => "V",
"SP" => "V",
"NC" => "V",
"FF" => "B",
"CC" => "V",
"CS" => "F",
"SB" => "C",
"OS" => "C",
"FN" => "O",
"CV" => "P",
"OH" => "H",
"OO" => "P",
"PO" => "F",
"NS" => "H",
"VB" => "K",
"OV" => "K",
"PH" => "H",
"BH" => "V",
"SS" => "B",
"PK" => "F",
"VK" => "O",
"BN" => "V",
"VF" => "O",
"PF" => "H",
"VS" => "K",
"ON" => "V",
"BF" => "F",
"CN" => "F",
"VO" => "B",
"FS" => "K",
"OB" => "B",
"PN" => "H",
"NF" => "O",
"VN" => "P",
"BV" => "S",
"NV" => "V",
"FB" => "V",
"NB" => "P",
"CB" => "B",
"KK" => "S",
"NN" => "F",
"SN" => "B",
"HB" => "P",
"PV" => "S",
"KN" => "S",
}

# rules = {
# "CH" => "B",
# "HH" => "N",
# "CB" => "H",
# "NH" => "C",
# "HB" => "C",
# "HC" => "B",
# "HN" => "C",
# "NN" => "C",
# "BH" => "H",
# "NC" => "B",
# "NB" => "B",
# "BN" => "B",
# "BB" => "N",
# "BC" => "B",
# "CC" => "N",
# "CN" => "C",
# }

rules.each{|k, v| asdf = k.split(""); temp = asdf[1]; asdf[1] = v; asdf << temp; rules[k] = asdf.join}

def tokenize(input)
  input = input.split("")
  asdf = input + [" "]
  input = [" "] + input
  return input.zip(asdf).map{|e|e.join}[1...-1]
end

# topinput = "NNCB"
topinput = "OOVSKSPKPPPNNFFBCNOV"

def doit(input, x, rules)
  x.times do |i|
    output = tokenize(input).map{|e| rules[e]}
    temp = output[-1]
    output = output.map { |e| e[0...-1] }
    output = output[0...-1].join+temp
    input = output
    print "."
  end
  return input
end

rule20 = {}
rules.keys.each do |k|
  print k + " "
  countdis = doit(k, 20, rules).split("")
  counts = Hash.new(0).tap { |h| countdis.each { |word| h[word] += 1 } }
  rule20[k] = counts
  puts
end

print topinput + " "
bigstring = doit(topinput, 20, rules)
bigtokens = tokenize(bigstring)

temp2 = bigtokens[0][0]
bigtokens2 = bigtokens.map{|e|e[0]}
ans = Hash.new(0).tap { |h| bigtokens.each {|token| rule20[token].each {|c, v| h[c] += v }}}
ncounts = Hash.new(0).tap {|h| bigtokens2.each { |e| h[e] += 1 }}

ncounts[temp2] -= 1
ncounts.each{|k, v| ncounts[k] = -1*v}

ans2 = ans.clone
ans2.each {|k, v| ans2[k] = ncounts[k] + v}
ans2 = ans2.sort_by{|k, v| v}
puts (ans2[-1][1] - ans2[0][1])

require 'pry'; binding.pry
puts
