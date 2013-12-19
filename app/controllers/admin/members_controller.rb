class Admin::MembersController < ApplicationController

  before_action :authenticate_admin!

  def index
    @admins = Admin.all
    @users = User.all
  end
end
