path = "./data/day_07_test.txt" unless path = ARGV.first?

crabs = File.read(path).split(',').map &.to_i

###################
# First Challenge #
###################

puts "\n\n"
puts "First Challenge"
puts "########################################"
puts "\n"

align_at = crabs.sort[crabs.size // 2]
fuel = 0
crabs.each do |crab|
  fuel += (crab - align_at).abs
end

puts "Total fuel cost: #{fuel}" # 37

####################
# Second Challenge #
####################

puts "\n\n"
puts "Second Challenge"
puts "########################################"
puts "\n"

# crabs.sum / crabs.size
# 4.9 on test data (correct: 5)
# 486.505 on full data set (correct: 486)

def round(num : Float) : Int
  n = num.round(1, mode: :ties_away)
  if n % 1 <= 0.5
    (n // 1).to_i
  else
    n.round.to_i
  end
end

align_at = round(crabs.sum / crabs.size)
fuel = 0
crabs.each do |crab|
  steps = (crab - align_at).abs
  fuel += (steps * (steps + 1) / 2).to_i
end

puts "Total fuel cost: #{fuel}" # 168
