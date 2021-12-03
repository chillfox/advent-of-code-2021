path = "./data/day_03_test.txt" unless path = ARGV.first?

###################
# First Challenge #
###################

puts "\n\n"
puts "First Challenge"
puts "########################################"
puts "\n"

numbers = 0
rate = [] of Int32

File.each_line(path) do |line|
  rate = Array.new line.size, 0 if rate.size < 1

  line.chars.each_with_index do |bit, idx|
    if bit.to_i == 1
      rate[idx] += 1
    end
  end

  numbers += 1
end

gamma = rate.map { |r| r > numbers / 2 ? 1 : 0 }
epsilon = rate.map { |r| r < numbers / 2 ? 1 : 0 }
power = gamma.join.to_i(2) * epsilon.join.to_i(2)

puts power

####################
# Second Challenge #
####################

puts "\n\n"
puts "Second Challenge"
puts "########################################"
puts "\n"

report = [] of Array(Int32)

File.each_line(path) do |line|
  report << line.chars.map { |c| c == '1' ? 1 : 0 }
end

def find_rating(bits, low = false)
  if bits.size > 1
    count = bits.transpose.first.tally.to_a.sort_by { |k, v| v }

    if low
      bit = count.first.last == count.last.last ? 0 : count.first.first
    else
      bit = count.first.last == count.last.last ? 1 : count.last.first
    end

    keep = bits.select { |b| b.first == bit }
    keep.map { |b| b.shift }

    [bit] + find_rating keep, low
  else
    bits.flatten
  end
end

oxygen = find_rating(report.clone).join.to_i 2
puts "Oxygen: #{oxygen}" # 10111 / 23

co2 = find_rating(report.clone, true).join.to_i 2
puts "CO2: #{co2}" # 01010 / 10

puts "Life Support: #{oxygen * co2}"
