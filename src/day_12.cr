path = "./data/day_12_test.txt" unless path = ARGV.first?

lines = File.read(path).lines
cave = lines.map &.split '-'

###################
# First Challenge #
###################

puts "\n\n"
puts "First Challenge"
puts "########################################"
puts "\n"

def find_paths(cave, paths : Array(Array(String)) = [["start"]]) : Array(Array(String))
  new_paths = paths.select { |path| path.last == "end" }

  (paths - new_paths).each do |path|
    valid_paths = cave.select { |c| c.includes? path.last }

    valid_paths = valid_paths.select do |vp|
      next_cave = vp.reject { |c| c == path.last }.first
      if next_cave == next_cave.downcase && path.includes? next_cave
        false
      else
        true
      end
    end

    valid_paths.each do |vp|
      next_cave = vp.reject(path.last).first
      next_path = path.dup.push next_cave
      new_paths << next_path
    end
  end

  if new_paths.all? { |path| path.last == "end" }
    new_paths
  else
    find_paths cave, new_paths
  end
end

cave_paths = find_paths cave
puts "There are #{cave_paths.size} paths through the cave."

####################
# Second Challenge #
####################

puts "\n\n"
puts "Second Challenge"
puts "########################################"
puts "\n"

def find_paths2(cave, paths : Array(Array(String)) = [["start"]]) : Array(Array(String))
  new_paths = paths.select { |path| path.last == "end" }

  (paths - new_paths).each do |path|
    valid_paths = cave.select { |c| c.includes? path.last }

    valid_paths = valid_paths.select do |vp|
      next_cave = vp.reject { |c| c == path.last }.first
      if next_cave == next_cave.downcase && path.count(next_cave) > 1 || next_cave == "start"
        false
      else
        true
      end
    end

    valid_paths.each do |vp|
      next_cave = vp.reject(path.last).first
      next_path = path.dup.push next_cave
      next if next_path.select { |c| c == c.downcase }.tally.count { |_, v| v > 1 } > 1
      new_paths << next_path
    end
  end

  if new_paths.all? { |path| path.last == "end" }
    new_paths
  else
    find_paths2 cave, new_paths
  end
end

cave_paths = find_paths2 cave
puts "There are #{cave_paths.size} paths through the cave."
