require 'spec_helper'

describe "Shows" do
  it "should be able to add new shows" do
    @show_name = "Family Guy"
    @show_picture_url = "http://magazine.100percentrock.com/wp-content/uploads/2013/01/Family-Guy.jpg"
    visit "/"

    page.should have_content("Shows List")

    click_link("New Show")

    page.should have_content("New Show")

    fill_in "Name", :with => @show_name
    fill_in "Picture", :with => @show_picture_url

    click_button "Submit"

    page.should have_content "Shows List"
    page.should have_content @show_name
    page.should have_content @show_picture_url
  end

  describe "show detail page" do
    let(:my_show) { FactoryGirl.create(:show) }

    before(:each) do
      my_show
    end

    it "should navigate to show" do
      visit "/"
      click_link(my_show.name)
      page.should have_content my_show.name
    end

    it "should be able to navigate to the edit page" do
      visit show_path(my_show)
      page.should have_link "Edit", :href => edit_show_path(my_show)
      click_link("Edit")
      expect(page).to have_title "Edit Page"
    end

    it "should be able to submit update show form" do
      @new_show_name = "New #{my_show.name}"
      visit edit_show_path(my_show)
      fill_in "Name", :with => @new_show_name
      click_button("Submit")
      expect(current_path).to eq show_path(my_show)
      expect(page).to have_content @new_show_name
    end

  end

  # context "show page view" do
  #   let!(:new_show) { FactoryGirl.create(:show) }

  #   it "should be able to go to show pages" do
  #     visit show_path(new_show.id)

  #   end
  # end
end
