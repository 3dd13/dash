require 'spec_helper'

describe Dashboard do

  context 'validations' do
    it "should validate for presence of name" do
      dashboard = FactoryGirl.build(:dashboard, name: nil)
      dashboard.should_not be_valid
    end
  end

  context 'endpoints' do

    it "should accept nested attributes for point_a" do
      cam = FactoryGirl.create(:dashboard,
        point_a_attributes: { address: 'Hong Kong Science Park'})

      cam.point_a.address.should eq 'Hong Kong Science Park'
    end

    it "should accept nested attributes for point_b" do
      cam = FactoryGirl.create(:dashboard,
        point_b_attributes: { address: 'Cyberport, Hong Kong'})

      cam.point_b.address.should eq 'Cyberport, Hong Kong'
    end

  end
end
