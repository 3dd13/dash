require 'spec_helper'

describe DashboardsController do

  shared_examples_for "user_login_required" do

    context "before user log in" do
      it "should redirect to users/sign_in" do
        response.code.should eq "302"
        response.location.should match "/users/sign_in"
      end
    end

    context "after user log in" do
      login_as_user

      it "should have a current_user" do
        subject.current_user.should_not be_nil
      end
    end

  end

  context "GET index" do
    before(:each) { get :index }
    it_should_behave_like "user_login_required"
  end

  context "GET show" do
    before(:each) do
      get :show, id: 1
    end
    it_should_behave_like "user_login_required"
  end

  context "GET new" do
    before(:each) { get :new }
    it_should_behave_like "user_login_required"
  end

  context "GET edit" do
    before(:each) { get :edit, id: 1 }
    it_should_behave_like "user_login_required"
  end

  context "POST create" do
    before(:each) { post :create, id: 1 }
    it_should_behave_like "user_login_required"
  end

  context "PUT update" do
    before(:each) { put :update, id: 1 }
    it_should_behave_like "user_login_required"
  end

  context "PATCH update" do
    before(:each) { patch :update, id: 1 }
    it_should_behave_like "user_login_required"
  end

  context "DELETE destroy" do
    before(:each) { delete :destroy, id: 1 }
    it_should_behave_like "user_login_required"
  end

  context "GET #cams" do
    before(:each) { get :cams }
    it_should_behave_like "user_login_required"
  end

end