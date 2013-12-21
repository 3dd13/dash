
u = User.first

u.dashboards.create({
  name: "Home to Work",
  point_a_attributes: { address: "King's Park", latitude: 22.311987, longitude: 114.17551 },
  point_b_attributes: { address: "HK Science Park", latitude: 22.43011, longitude: 114.208625 }
}).cams << Cam.first(8)

u.dashboards.create({
  name: "Work to Home",
  point_a_attributes: { address: "HK Science Park", latitude: 22.43011, longitude: 114.208625 },
  point_b_attributes: { address: "King's Park", latitude: 22.311987, longitude: 114.17551 }
}).cams << Cam.last(6)

u.dashboards.create({
  name: "Work to GA Class",
  point_a_attributes: { address: "HK Science Park", latitude: 22.43011, longitude: 114.208625 },
  point_b_attributes: { address: "Citicorp Centre, Causeway Bay", latitude: 22.286406, longitude: 114.190294 }
})

u.dashboards.create({
  name: "GA Class to Work",
  point_a_attributes: { address: "Citicorp Centre, Causeway Bay", latitude: 22.286406, longitude: 114.190294 },
  point_b_attributes: { address: "HK Science Park", latitude: 22.43011, longitude: 114.208625 }
})
