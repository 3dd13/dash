class DashboardsController < ApplicationController

  before_action :authenticate_user!, except: [:new]
  before_action :set_dashboard, only: [:show, :edit, :update, :destroy, :cams, :test]
  before_action :set_gui, only: [:show, :edit]

  # GET /dashboards
  # GET /dashboards.json
  def index
    @dashboards = current_user.dashboards.includes([:point_a, :point_b])
  end

  # GET /dashboards/1
  # GET /dashboards/1.json
  def show
  end

  # GET /dashboards/new
  def new
    @dashboard = Dashboard.new
    @dashboard.build_point_a(
      address: 'Hong Kong Science Park, Hong Kong', latitude: 22.429198, longitude: 114.208711)
    @dashboard.build_point_b(
      address: 'Cyberport, Hong Kong', latitude: 22.258537, longitude: 114.131338)
    set_gui
  end

  # GET /dashboards/1/edit
  def edit
  end

  # POST /dashboards
  # POST /dashboards.json
  def create
    @dashboard = current_user.dashboards.build(dashboard_params)
    if (camera_ids = params[:dashboard][:camera_ids])
      @dashboard.cams = Cam.find(camera_ids.split(','))
    end

    respond_to do |format|
      if @dashboard.save
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully created.' }
        format.json { redirect_to @dashboard }
        # format.json { render action: 'show', status: :created, location: @dashboard }
      else
        format.html { render action: 'new' }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dashboards/1
  # PATCH/PUT /dashboards/1.json
  def update

    if (camera_ids = params[:dashboard][:camera_ids])
      @dashboard.cams = Cam.find(camera_ids.split(','))
    end

    respond_to do |format|
      if @dashboard.update(dashboard_params)
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully updated.' }
        format.json { redirect_to @dashboard }
      else
        format.html { render action: 'edit' }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dashboards/1
  # DELETE /dashboards/1.json
  def destroy
    @dashboard.destroy
    respond_to do |format|
      format.html { redirect_to dashboards_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dashboard
      @dashboard = Dashboard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dashboard_params
      params.require(:dashboard).permit(:name, :user_id,
          point_a_attributes: [ :address, :latitude, :longitude ],
          point_b_attributes: [ :address, :latitude, :longitude ])
    end

    def set_gui
      gon.dashboard = {
        origin: @dashboard.point_a.to_latlng,
        destination: @dashboard.point_b.to_latlng,
        markers: markers,
        marker_template: marker_template
      }
    end

    def markers
      Cam.includes(:location).all.map do |c|
        c.location.to_latlng.merge({
          id: c.id,
          name: c.name,
          data: { id: c.id, uri: c.uri, name: c.name, address: c.address }
        })
      end
    end

    def marker_template
      <<-EOS
        <div class='cam' id='{{id}}' style="background-image: url('{{uri}}');">
          <div class="location"> {{name}}: {{address}} </div>
        </div>
      EOS
    end
end
