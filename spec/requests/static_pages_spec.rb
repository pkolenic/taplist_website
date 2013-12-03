require 'spec_helper'

describe "StaticPages" do
  
  let(:base_title) { "TapList" }
  
  describe "Home page" do
    it "should have the content 'TapList'" do
      visit '/static_pages/home'
      expect(page).to have_content('TapList')
    end
    
    it "should have the right title" do
      visit '/static_pages/home'
      expect(page).to have_title("#{base_title} | Home")
    end
  end

  describe "Help page" do
    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end
    
    it "should have the right title 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_title("#{base_title} | Help")
    end
  end
  
  describe "Contact page" do
    it "should have the content 'Contact Us'" do
      visit '/static_pages/contact'
      expect(page).to have_content('Contact Us')
    end
    
    it "should have the right title 'Contact Us'" do
      visit '/static_pages/contact'
      expect(page).to have_title("#{base_title} | Contact Us")
    end
  end
end

