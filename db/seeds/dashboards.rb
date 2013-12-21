
u = User.first
u.dashboards.create({
  name: "Work to GA Class",
  point_a_attributes: { address: "hong kong science park", latitude: 22.43011, longitude: 114.208625 },
  point_b_attributes: { address: "The Hive, 21/F, The Phoenix, Luard Road No. 23 Wan Chai, Hong Kong", latitude: 22.279963, longitude: 114.171712 }
}).cams << Cam.first(6)

u.dashboards.create({
  name: "GA Class to Work",
  point_a_attributes: { address: "The Hive, 21/F, The Phoenix, Luard Road No. 23 Wan Chai, Hong Kong", latitude: 22.279963, longitude: 114.171712 },
  point_b_attributes: { address: "hong kong science park", latitude: 22.43011, longitude: 114.208625 }
}).cams << Cam.last(8)
