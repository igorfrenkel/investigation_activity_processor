require 'rails_helper'

data = <<END_CSV
"INVESTIGATION_ID","ASSESSED_OR_MAILING_ADDRESS","PROPHOUSE","PROPSTREET","PROPSTREETTYPE","PROPSTREETDIRECTION"
4476055,"19 SAYWELL AVE","19","SAYWELL","AVE",""
4109269,"9 TOMPKINS MEWS","9","TOMPKINS","MEWS",""
4131265,"5225 FINCH AVE E","5225","FINCH","AVE","E"
4219864,"5225 FINCH AVE E","5225","FINCH","AVE","E"
4099063,"10 CHICHESTER PL","10","CHICHESTER","PL",""
4099896,"10 CHICHESTER PL","10","CHICHESTER","PL",""
4134466,"10 CHICHESTER PL","10","CHICHESTER","PL",""
4196305,"55 MAC FROST WAY","55","MAC FROST","WAY",""
4124322,"669 QUEEN ST E","669","QUEEN","ST","E"
END_CSV

expected_json = [{"id":1,"address":"19 SAYWELL AVE","investigation_id":nil,"created_at":"2018-12-20T14:47:38.678Z","updated_at":"2018-12-20T14:47:38.678Z"},{"id":2,"address":"9 TOMPKINS MEWS","investigation_id":nil,"created_at":"2018-12-20T14:47:38.681Z","updated_at":"2018-12-20T14:47:38.681Z"},{"id":3,"address":"5225 FINCH AVE E","investigation_id":nil,"created_at":"2018-12-20T14:47:38.684Z","updated_at":"2018-12-20T14:47:38.684Z"},{"id":4,"address":"10 CHICHESTER PL","investigation_id":nil,"created_at":"2018-12-20T14:47:38.698Z","updated_at":"2018-12-20T14:47:38.698Z"},{"id":5,"address":"55 MAC FROST WAY","investigation_id":nil,"created_at":"2018-12-20T14:47:38.701Z","updated_at":"2018-12-20T14:47:38.701Z"},{"id":6,"address":"669 QUEEN ST E","investigation_id":nil,"created_at":"2018-12-20T14:47:38.703Z","updated_at":"2018-12-20T14:47:38.703Z"}]

RSpec.describe LocationsController, type: :controller do
  describe("import") do
    context("happy path") do
      it("generates Locations from generated csv") do
        expect(Location.count).to eq(0)
        post :create, params: { :data => data }
        expect(response).to have_http_status(:created)
        #resp = JSON.parse(response.body)
        #expect(resp).to eq(expected_json)
        expect(Location.count).to eq(6)
      end
    end

    context("error") do

    end
  end

  describe("top N") do
    context("happy path") do
      before(:each) do
        @first_address = "1 foo st"
        @second_address = "2 foo st"
        Location.create(address: @first_address)
        Location.create(address: @first_address)
        Location.create(address: @first_address)
        Location.create(address: @second_address)
      end

      it("returns the top N addresses ordered by appearance") do
        get :index
        resp = JSON.parse(response.body)
        expect(resp["data"]).to eq([@first_address, @second_address])
      end
    end
  end
end
