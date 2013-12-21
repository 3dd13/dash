Admin.create( email: "admin@creaxon.com", password: "bigsecret" )

u = User.new( email: "user@creaxon.com", password: "bigsecret" )
u.skip_confirmation!
u.save

