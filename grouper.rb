
address_count = {}
csv.for_each do |l|
  line = CSV.parse(l)
  next if line.length != 1
  line = line[0]
  if line[0] != 'INVESTIGATION_ID'
    address_count[line[1]] ||= 0
    address_count[line[1]]+=1
  end
end
puts address_count
