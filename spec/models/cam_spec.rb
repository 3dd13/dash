require 'spec_helper'

describe Cam do
  context 'validation' do

    it "should validate presence of name" do
      cam = FactoryGirl.build(:cam, name: nil)
      cam.should_not be_valid
    end

    it "should validate presence of uri" do
      cam = FactoryGirl.build(:cam, uri: nil)
      cam.should_not be_valid
    end

  end

  context 'location' do

    it "should accept nested attributes for location" do
      cam = FactoryGirl.create(:cam,
        location_attributes: {
          address: 'Shatin, Hong Kong',
          latitude: 22.387222,
          longitude: 114.209697
        })
      cam.location.address.should eq 'Shatin, Hong Kong'
    end

    it "should delegate address to location" do
      cam = FactoryGirl.create(:cam)
      cam.address.should_not be_nil
      cam.address.should eq cam.location.address
    end

    it "should delegate latitude to location" do
      cam = FactoryGirl.create(:cam)
      cam.latitude.should_not be_nil
      cam.latitude.should eq cam.location.latitude
    end

    it "should delegate longitude to location" do
      cam = FactoryGirl.create(:cam)
      cam.longitude.should_not be_nil
      cam.longitude.should eq cam.location.longitude
    end

  end

end
