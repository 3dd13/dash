module TsmsHelper
  def tsm_colorize(tsm)
    (tsm.road_saturation_level =~ /BAD/) and return 'danger'
    (tsm.road_saturation_level =~ /GOOD/) and return 'success'
  end
end
