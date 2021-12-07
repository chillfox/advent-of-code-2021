path = "./data/day_06_test.txt" unless path = ARGV.first?

lanternfish = File.read(path).split(',').map &.to_i8

###################
# First Challenge #
###################

puts "\n\n"
puts "First Challenge"
puts "########################################"
puts "\n"

def age_fish(fish : Array(Int8), days : Int32) : Array(Int8)
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

def age_fish(fish : Hash(Int8, Int64), days : Int32) : Hash(Int8, Int64)
  return fish if days == 0

  new_fish = Hash(Int8, Int64).new
  9_i8.times do |age|
    next unless fish[age]?

    if age > 0
      new_fish[age - 1] = new_fish[age - 1]? ? new_fish[age - 1] + fish[age] : fish[age]
    else
      new_fish[6_i8] = new_fish[6_i8]? ? new_fish[6_i8] + fish[age] : fish[age]
      new_fish[8_i8] = fish[age]
    end
  end

  age_fish new_fish, days - 1
end

fish_tally = lanternfish.tally.map { |k, v| {k, v.to_i64} }.to_h
fish_count = age_fish(fish_tally, 256).values.sum
puts "lanternfish: #{fish_count}" # 26984457539
