require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    it "should have the content 'TapList'" do
      visit '/static_pages/home'
      expect(page).to have_content('TapList')
    end
    
    it "should have the right title" do
      visit '/static_pages/home'
      expect(page).to have_title('Taplist | Home')
    end
  end

  describe "Help page" do
    it "should have the content 'Help" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end
    
    it "should have hte right title" do
      visit '/static_pages/help'
      expect(page).to have_title('Taplist | Help')
    end
  end
end

