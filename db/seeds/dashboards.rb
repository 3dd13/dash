
u = User.first

u.dashboards.create({
  name: "PFL to SP",
  point_a_attributes: { address: "Pok Fu Lam, Hong Kong" },
  point_b_attributes: { address: "HK Science Park" }
}).cams << Cam.first(8)

u.dashboards.create({
  name: "SP to PFL",
  point_a_attributes: { address: "HK Science Park" },
  point_b_attributes: { address: "Pok Fu Lam, Hong Kong" }
}).cams << Cam.last(6)

u.dashboards.create({
  name: "SP to GA",
  point_a_attributes: { address: "HK Science Park" },
  point_b_attributes: { address: "Citicorp Centre, Causeway Bay" }
})

u.dashboards.create({
  name: "GA to SP",
  point_a_attributes: { address: "Citicorp Centre, Causeway Bay" },
  point_b_attributes: { address: "HK Science Park" }
})
