
u = User.first
d = Dashboard.create({name: "work"})
u.dashboards << d
d.cams << Cam.first(6)
