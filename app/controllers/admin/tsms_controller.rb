class Admin::TsmsController < ApplicationController

  before_action :authenticate_admin!

  def index
    @tsms = Tsm.includes([:start_location,:end_location]).all
  end
end
