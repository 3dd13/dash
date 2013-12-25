FactoryGirl.define do
  factory :dashboard do
    name "HKSP to Cyperport"

    association :point_a, factory: :location, address: 'Hong Kong Science Park'
    association :point_b, factory: :location, address: 'Cyberport, Hong Kong'
  end
end