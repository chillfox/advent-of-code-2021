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
