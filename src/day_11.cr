path = "./data/day_11_test.txt" unless path = ARGV.first?

dumbo = [] of Array(Int8)

File.each_line(path) do |line|
  dumbo << line.chars.map &.to_i8
end

def flash(energy : Array(Array(Int8))) : Array(Array(Int8))
  if energy.flatten.any? { |e| e > 9 }
    energy.each_with_index do |y, idx|
      if x = y.index { |e| e > 9 }
        # pp "#{y[x]} (x: #{x}, y: #{idx})"

        energy[idx][x] = 0
        energy[idx][x - 1] += 1 if x > 0 && energy[idx][x - 1] > 0
        energy[idx][x + 1] += 1 if (energy[idx].size - 1) > x && energy[idx][x + 1] > 0

        energy[idx - 1][x] += 1 if idx > 0 && energy[idx - 1][x] > 0
        energy[idx - 1][x - 1] += 1 if idx > 0 && x > 0 && energy[idx - 1][x - 1] > 0
        energy[idx - 1][x + 1] += 1 if idx > 0 && (energy[idx].size - 1) > x && energy[idx - 1][x + 1] > 0

        energy[idx + 1][x] += 1 if (energy.size - 1) > idx && energy[idx + 1][x] > 0
        energy[idx + 1][x - 1] += 1 if (energy.size - 1) > idx && x > 0 && energy[idx + 1][x - 1] > 0
        energy[idx + 1][x + 1] += 1 if (energy.size - 1) > idx && (energy[idx].size - 1) > x && energy[idx + 1][x + 1] > 0

        break
      end
    end
    flash energy
  else
    energy
  end
end

###################
# First Challenge #
###################

puts "\n\n"
puts "First Challenge"
puts "########################################"
puts "\n"

octopuses = dumbo.clone
flashes = 0
100.times do
  octopuses = octopuses.map &.map { |e| e += 1 }
  octopuses = flash octopuses
  flashes += octopuses.flatten.count 0
end

puts "The dumbo octopuses flashes #{flashes} times"

####################
# Second Challenge #
####################

puts "\n\n"
puts "Second Challenge"
puts "########################################"
puts "\n"

octopuses = dumbo.clone
# flashes = 0
synchronized_flash = 0
1000.times do |i|
  octopuses = octopuses.map &.map { |e| e += 1 }
  octopuses = flash octopuses
  # flashes += octopuses.flatten.count 0

  synchronized_flash = i + 1 if octopuses.flatten.count(0) == octopuses.flatten.size
  break if synchronized_flash > 0
end

puts "The first synchronized flash occurs at #{synchronized_flash}"
