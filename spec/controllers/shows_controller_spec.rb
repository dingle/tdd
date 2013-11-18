require 'spec_helper'

describe ShowsController do

  describe "#index" do
    before do
      @show = FactoryGirl.create(:show)
    end

    it "should be successful" do
      get :index

      response.should be_success
      assigns[:shows].should include(@show)
    end
  end

  describe "#show" do
    it "should get to the show page" do
    end
  end

  describe "#new" do
    it "should be successful" do
      get :new

      response.should be_success
    end

    it "should create a new instance of a Show" do
      get :new

      assigns(:show).should be_an_instance_of(Show)
    end
  end

  describe "#create" do
    def perform
      post :create, :show => {:name => "Family Guy", :picture => "http://something.com/pic.png"}
    end

    it "should redirect to the shows index" do
      perform

      response.should be_redirect
      response.location.should == shows_url
    end

    it "should create a Show" do
      lambda do
        perform
      end.should change(Show, :count).by(1)

      show = Show.last
      expect(show.name).to eq "Family Guy"
      expect(show.picture).to eq"http://something.com/pic.png"
    end

    describe "when passing invalid input" do
      it "should not create a show" do
        lambda do
          post :create, :show => {:name => "Family Guy"}
        end.should_not change(Show, :count)

        response.should_not be_success
      end
    end
  end

  describe "#update" do
    before :each do
      @show = FactoryGirl.create(:show)
    end

    def update_action
      patch :update, :id => @show.id, :show => {:name => "Updated #{@show.name}", :picture => @show.picture}
    end

    it "should update the show's name" do
      update_action
      @new_show = Show.find(@show.id)
      expect(@new_show.name).to eq("Updated #{@show.name}")
    end
  end

end