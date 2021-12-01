path = "./data/day_01_test.txt" unless path = ARGV.first?

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
