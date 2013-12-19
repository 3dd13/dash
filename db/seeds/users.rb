user = User.new( email: "mtsai@creaxon.com", password: "bigsecret" )
user.skip_confirmation!
user.save

Admin.create( email: "admin@creaxon.com", password: "biglsecret" )
