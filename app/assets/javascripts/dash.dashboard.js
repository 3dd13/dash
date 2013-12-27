var Dash = Dash || {};
Dash.dashboard = (function($){
  var config = {
        origin: {lat: 22, lng: 144},
        destination: {lat: 23, lng: 145},
        markers: [],
        callback: null,
        icon: {
          pin_a: '/assets/pin_a.png',
          pin_b: '/assets/pin_b.png',
          marker_onpath: '/assets/red_dot12x12.png',
          marker_offpath: '/assets/white_dot12x12.png'
        }
      },
      map,

      view_all = function(){
        var bounds = new google.maps.LatLngBounds();
        bounds.extend(new google.maps.LatLng(config.origin.lat, config.origin.lng));
        bounds.extend(new google.maps.LatLng(config.destination.lat, config.destination.lng));
        map.fitBounds(bounds);
      },

      zoom_in = function(marker){
        map.setZoom(15);
        map.panTo(marker.getPosition())
      },

      draw_markers = function(result, tol){
        var poly = new google.maps.Polyline({ path: result.overview_path }),
            onpath_marker_ids = [];

        if (typeof tol === 'undefined') { tol = 1e-3 }
        $.each(config.markers, function(i,m){
          var point = new google.maps.LatLng(m.lat, m.lng);

          m.click = zoom_in;
          if (google.maps.geometry.poly.isLocationOnEdge(point, poly, tol)) {
            m.icon = config.icon.marker_onpath;
            onpath_marker_ids.push(m.id);
          } else {
            m.icon = config.icon.marker_offpath;
          }
        })
        map.addMarkers(config.markers);
        return onpath_marker_ids;
      },

      draw_endpoints = function(){
        var endpoints = [];
        endpoints.push( $.extend({}, config.origin, { click: zoom_in, icon: config.icon.pin_a }));
        endpoints.push( $.extend({}, config.destination, { click: zoom_in, icon: config.icon.pin_b }));
        map.addMarkers(endpoints);
      },

      initialize = function(map_div, options){

        $.extend(config, options);
        map = new GMaps({ div: map_div, scrollwheel: false });

        google.maps.event.addListener(map.map, 'click', view_all);
        map.addLayer('traffic');
        draw_endpoints();
        view_all();
      },

      dashboard = function(map_div, options){
        initialize(map_div, options);
        map.drawRoute({
          origin: [ config.origin.lat, config.origin.lng ],
          destination: [ config.destination.lat, config.destination.lng ],
          travelMode: 'driving',
          strokeColor: '#FF00FF',
          strokeOpacity: 0.3,
          strokeWeight: 16,
          callback: function(result){
            var distance = result.legs[0].distance.value,
                duration = result.legs[0].duration.value,
                onpath_marker_ids = draw_markers(result);
            if (typeof config.callback === 'function') {
              config.callback.call(this, distance, duration, onpath_marker_ids);
            }
          }
        });
      };

  return dashboard;

}(jQuery));
