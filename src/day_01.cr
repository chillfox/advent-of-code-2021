path = "./data/day_01_test.txt" unless path = ARGV.first?

###################
# First Challenge #
###################

puts "\n\n"
puts "First Challenge"
puts "########################################"
puts "\n"

last_depth = nil
increases = 0

File.each_line(path) do |line|
  depth = line.to_i

  if last_depth
    if last_depth < depth
      increases += 1
      puts "#{depth} (increased)"
    else
      puts "#{depth} (decreased)"
    end
  else
    puts "#{depth} (N/A - no previous measurement)"
  end

  last_depth = depth
end

puts "Depth increased #{increases} times"

####################
# Second Challenge #
####################

puts "\n\n"
puts "Second Challenge"
puts "########################################"
puts "\n"

window = [] of Int64
increases = 0

File.each_line(path) do |line|
  depth = line.to_i64
  window << depth
  window.shift if window.size > 4

  if window.size == 4
    if window[0, 3].sum < window[1, 4].sum
      puts "#{window[1, 4].sum} (increased)"
      increases += 1
    elsif window[0, 3].sum > window[1, 4].sum
      puts "#{window[1, 4].sum} (decreased)"
    else
      puts "#{window[1, 4].sum} (no change)"
    end
  elsif window.size == 3
    puts "#{window.sum} (N/A - no previous sum)"
  end
end

puts "Sum increased #{increases} times"
