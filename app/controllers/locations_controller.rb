require 'csv'

class LocationsController < ApplicationController
  def index
    addresses = Location.group(:address).map{ |a|  a.address }
    render json: { data: addresses }
  end

  def create
    unique_addresses = {}

    CSV.parse(params[:data]) do |row|
      next if row[0] == 'INVESTIGATION_ID'
      investigation_id = row[0]
      address = row[1]
      unique_addresses[address] = true
    end

    result = []
    unique_addresses.each do |address, _|
      result << Location.create(address: address)
    end

    render status: 201, json: result
  end
end
