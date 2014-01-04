$.widget("dash.dashboard", {

  options: {
    origin: new google.maps.LatLng( 22.338962, 114.041126 ),
    destination: new google.maps.LatLng( 22.503359, 114.107044 ),
    markers: [{id:1, data: '<div>info</div>', lat: 22.413568, lng: 114.112194 }],
    icon: {
      pin_a: '/assets/pin_a.png',
      pin_b: '/assets/pin_b.png',
      marker_onpath: '/assets/red_dot12x12.png',
      marker_offpath: '/assets/white_dot12x12.png'
    },

    directionRendererOptions: {
      draggable: true,
      polylineOptions: {
        strokeColor: '#FF00FF',
        strokeOpacity: 0.3,
        strokeWeight: 16
      }
    }
  },

  _sort_markers: function(markers, path, tol){
    var that = this,
        poly = new google.maps.Polyline({ path: path }),
        result = { onpath: [], offpath: [] };

    if (typeof tol === 'undefined') { tol = 2e-3 }
    $.each(markers, function(i,m){
      var point = new google.maps.LatLng(m.lat, m.lng),
          onEdge = google.maps.geometry.poly.isLocationOnEdge,
          origin = new google.maps.LatLng(path[0].lat(), path[0].lng());

      if (onEdge(point, poly, tol)) {
        $.extend(m, {
          options: { icon: that.options.icon.marker_onpath },
          distance: google.maps.geometry.spherical.computeDistanceBetween(origin, point)
        });
        result.onpath.push(m);
      } else {
        $.extend(m, {options: { icon: that.options.icon.marker_offpath }});
        result.offpath.push(m)
      }
    });
    result.onpath.sort(function(a,b){return (a.distance - b.distance); });
    return result;
  },

  _redraw_markers: function(markers, path) {
    var orig = path[0],
        dest = path[path.length-1],
        sorted_markers;

    sorted_markers = this._sort_markers(markers, path);

    this.options.origin = new google.maps.LatLng( orig.lat(), orig.lng() );
    this.options.destination = new google.maps.LatLng( dest.lat(), dest.lng() );

    this._trigger("on_markers_ready", null, sorted_markers);

    this.element.gmap3({
      clear: {
        name: 'marker'
      },
      marker: {
        values: markers,
        options: { draggable: false },
        events: { click: $.proxy(this._zoom_to_marker,this) }
      }
    });
  },

  _create: function() {
    google.maps.visualRefresh = true;
    this._redraw(this.options.origin, this.options.destination);
  },

  _redraw: function(origin, destination) {
    var that = this;

    this.element.gmap3({
      clear: {
        name: ["directionsrenderer"]
      }
    });

    this.element.gmap3({
      map: {
        options: { scrollwheel: false },
        events: { click: $.proxy(this._zoom_all, this) }
      },
      trafficlayer: {},
      getroute: {
        options: {
          origin: origin,
          destination: destination,
          travelMode: google.maps.DirectionsTravelMode.DRIVING
        },

        callback: function(result){
          var path = result.routes[0].overview_path,
              leg = result.routes[0].legs[0];

          if (!result) return;

          that.options.origin = leg.start_location;
          that.options.destination = leg.end_location;

          that._trigger('on_route_ready', null, {
            distance: leg.distance.value,
            duration: leg.duration.value,
            addresses: {origin: null, destination: null}
          });

          that._redraw_markers(that.options.markers,path);

          $(this).gmap3({
            directionsrenderer: {
              options: $.extend(that.options.directionRendererOptions,
                { directions: result }),
              events: {
                directions_changed: function(result) {

                  var directions = result.directions,
                      leg = directions.routes[0].legs[0],
                      path = directions.routes[0].overview_path,
                      addresses = {origin: null, destination: null};

                  addresses.origin = leg.start_address;
                  addresses.destination = leg.end_address;
                  that._trigger('on_route_ready', null, {
                    distance: leg.distance.value,
                    duration: leg.duration.value,
                    addresses: addresses
                  });

                  that._redraw_markers(that.options.markers,path);
                }
              }
            } // directionsrenderer
          });

        }
      }
    });

  },

  _zoom_all: function(obj) {
    var el = this.element,
        map = el.gmap3("get"),
        bounds = new google.maps.LatLngBounds();

    bounds.extend(this.options.origin);
    bounds.extend(this.options.destination);
    map.fitBounds(bounds);
  },

  _zoom_to_marker: function(marker, event, context){
    var el = this.element,
        map = el.gmap3("get"),
        infowindow = el.gmap3({get:{name:"infowindow"}});

    if (! infowindow ) {
      el.gmap3({
        infowindow: {
          anchor: marker,
          option: { content: context.data }
        }
      });
      infowindow = el.gmap3({get:{name:"infowindow"}});
    }

    infowindow.open(map, marker);
    infowindow.setContent(context.data);
    map.setZoom(15);
    map.panTo(marker.position);
  },

  _destroy: function() {
  },

  new_route: function(type_or_address, address) {
    var that = this,
        geocoder = new google.maps.Geocoder();

    if (type_or_address === 'origin') {
      that._redraw(address, that.options.destination);
    } else if (type_of_address === 'destination') {
      that._redraw(that.options.origin, address);
    } else {
      that._redraw(type_or_address, address);
    }
  }
});
