require 'csv'
require 'memprof2'

address_count = {}
STDIN.each_line do |l|
  line = CSV.parse(l)
  next if line.length != 1
  line = line[0]
  if line[0] != 'INVESTIGATION_ID'
    address_count[line[1]] ||= 0
    address_count[line[1]]+=1
  end
end

address_count = address_count
  .sort { |a,b| a[1] <=> b[1] }
  .reverse

count = 0
address_count.each do |k,v|
  puts "#{k}: #{v}"
  count += 1
  break if count > 100
end
