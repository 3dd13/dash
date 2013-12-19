user1 = User.new( email: "mtsai@creaxon.com", password: "bigsecret" )
user1.skip_confirmation!
user1.save

user2 = User.create( email: "user@creaxon.com", password: "smallsecret" )
user2.skip_confirmation!
user2.save

user1.services << Service.create( name: "admin" )
user2.services << Service.create( name: "dashboard" )
