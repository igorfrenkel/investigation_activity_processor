require 'csv'

STDIN.each_line do |l|
  line = CSV.parse(l)
  next if line.length != 1
  line = line[0]
  if line[0] != 'INVESTIGATION_ID'
    line[1] = line[1] + ", TORONTO, ONTARIO"
  end
  puts CSV.generate { |csv| csv << line }
end
