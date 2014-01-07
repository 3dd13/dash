class Admin::TsmsController < ApplicationController

  before_action :authenticate_admin!

  def index
    @tsms = Tsm.includes([:start_location,:end_location]).all
  end

  def map
    stroke_options = {
      'TRAFFIC BAD'     => { strokeColor: '#FF0000', strokeWeight: 2, strokeOpacity: 1.0, zIndex: 3 },
      'TRAFFIC AVERAGE' => { strokeColor: '#0000FF', strokeWeight: 2, strokeOpacity: 1.0, zIndex: 2 },
      'TRAFFIC GOOD'    => { strokeColor: '#006600', strokeWeight: 2, strokeOpacity: 1.0, zIndex: 1 }
    }

    tsms = Tsm.includes(:start_location, :end_location).all
    cams = Cam.includes(:location).all

    gon.markers = cams.map do |c|
      c.location.to_latlng.merge({
        name: c.name,
        options: { icon: '/assets/red_dot12x12.png' },
        data: "#{render_to_string partial: '/admin/cams/cam', locals:{cam: c} }"
      })
    end

    gon.polylines = tsms.map do |t|
      { polyline: {
          options: {
              path: [ [t.start_location.latitude,t.start_location.longitude],
                      [t.end_location.latitude,t.end_location.longitude] ]
            }.merge(stroke_options[t.road_saturation_level]),
          data: "#{render_to_string partial: '/admin/tsms/tsm', locals:{tsm: t} }"
        },
      }
    end

  end

end