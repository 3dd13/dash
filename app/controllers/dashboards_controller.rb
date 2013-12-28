class DashboardsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_dashboard, only: [:show, :edit, :update, :destroy, :cams, :test]

  # GET /dashboards
  # GET /dashboards.json
  def index
    @dashboards = current_user.dashboards.includes([:point_a, :point_b])
  end

  # GET /dashboards/1
  # GET /dashboards/1.json
  def show
    @cams = @dashboard.cams

    gon.origin = @dashboard.point_a.to_latlng
    gon.destination = @dashboard.point_b.to_latlng
    gon.markers = Cam.all.map do |c|
      { id: c.id,
        details: c.name,
        infoWindow: { content: render_to_string(partial: 'cam', locals: { cam: c }) }
      }.merge(c.location.to_latlng)
    end
  end

  # GET /dashboards/1/test
  # GET /dashboards/1/test.json
  def test
    @cams = @dashboard.cams

    gon.origin = @dashboard.point_a.to_latlng
    gon.destination = @dashboard.point_b.to_latlng
    gon.markers = Cam.all.map do |c|
      { id: c.id,
        details: c.name,
        infoWindow: { content: render_to_string(partial: 'cam', locals: { cam: c }) }
      }.merge(c.location.to_latlng)
    end
  end

  # GET /dashboards/new
  def new
    @dashboard = Dashboard.new
    @dashboard.build_point_a
    @dashboard.build_point_b
  end

  # GET /dashboards/1/edit
  def edit
  end

  # POST /dashboards
  # POST /dashboards.json
  def create
    @dashboard = Dashboard.new(dashboard_params)
    @dashboard.user_id = current_user.id

    respond_to do |format|
      if @dashboard.save
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully created.' }
        format.json { render action: 'show', status: :created, location: @dashboard }
      else
        format.html { render action: 'new' }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dashboards/1
  # PATCH/PUT /dashboards/1.json
  def update
    respond_to do |format|
      if @dashboard.update(dashboard_params)
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully updated.' }
        format.json { head :no_content }
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

  def cams
    ids = params[:ids].split(/[^\d]/)
    cams = Cam.includes(:location).find(ids)
    (@dashboard.cams != cams) and @dashboard.cams = cams
    cams = cams.map do |c|
      c.as_json.merge html: "#{render_to_string partial: 'cam', locals: { cam: c }, formats: [:html]}"
    end
    respond_to do |format|
      format.json { render json: cams}
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
end
