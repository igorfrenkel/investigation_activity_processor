addresses = parse_csv()
violations = count_violations_by_address(addresses)
address_count.each do |addr, count|
  save_count(addr, count)
  geo = geocode(addr)
  save_geo(addr, geo)
end

def save_count(address, count)
  db.insert(address, count)
end

def geocode(address)
  result = db.select(address)
  return result[0] if result != nil
  result = _geocode(address)
  raise Error('geocoding error') if result == nil
  return result[0]
end

def save_geo(addr, geo)
  db.save(address, geo)
end
