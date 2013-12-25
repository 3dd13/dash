require 'spec_helper'

describe Location do
  context 'geocoding' do
    it "should goecode from address if coordinates are missing" do
      loc = FactoryGirl.create(:location, latitude: nil, longitude: nil)
      loc.latitude.should_not be_nil
      loc.longitude.should_not be_nil
    end

    it "should not overwrite existing coordiantes" do
      loc = FactoryGirl.create(:location, latitude: 22.2, longitude: 114.2)
      loc.latitude.should eq 22.2
      loc.longitude.should eq 114.2
    end
  end
end
