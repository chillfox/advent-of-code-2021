path = "./data/day_06_test.txt" unless path = ARGV.first?

lanternfish = File.read(path).split(',').map &.to_i8

###################
# First Challenge #
###################

puts "\n\n"
puts "First Challenge"
puts "########################################"
puts "\n"

def age_fish(fish, days) : Array(Int8)
  return fish if days == 0
  new_fish = [] of Int8

  fish.each do |f|
    if f > 0
      new_fish << f - 1
    else
      new_fish << 6_i8
      new_fish << 8_i8
    end
  end

  age_fish new_fish, days - 1
end

puts "lanternfish: #{age_fish(lanternfish, 80).size}" # 5934

####################
# Second Challenge #
####################

puts "\n\n"
puts "Second Challenge"
puts "########################################"
puts "\n"

# puts "lanternfish: #{age_fish(lanternfish, 265).size}" # 26984457539

# TODO: write something that is more memory efficint
# maybe handle the generations of each fish one at a time instead of iterating over all of the fish...
