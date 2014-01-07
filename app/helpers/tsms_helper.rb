module TsmsHelper
  def tsm_colorize(tsm)
    (tsm.road_saturation_level =~ /BAD/) and return 'danger'
    (tsm.road_saturation_level =~ /GOOD/) and return 'success'
  end

  def traffic_speed_km(tsm)
    "#{"%d" % tsm.traffic_speed} km/h"
  end

  def distance_m(tsm)
    "#{"%d" % (tsm.start_location.distance_from(tsm.end_location,:km) * 1000) } m"
  end

end
