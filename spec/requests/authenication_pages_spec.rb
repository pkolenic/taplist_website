require 'spec_helper'

describe "AuthenicationPages" do
  
  subject { page }
  
  describe "sigin page" do    # Need to test both generic and company specific sign pages
    before { visit signin_path }
    
    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end
  
  describe "signin" do
    before { visit signin_path }
    
    describe "with invalid information" do
      before { click_button "Sign in"}
      
      it { should have_title('Sign in') }
      it { should have_error_message('Invalid') }
      
      describe "after visiting another page" do
        before { click_link "logo" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end
    
    describe "with valid information" do
      let(:user)    { FactoryGirl.create(:user) }
      before { valid_signin(user) }
      
      it { should have_title(user.full_name) }
      it { should have_link('Profile',      href: user_path(user)) }
      it { should have_link('Sign out',     href: signout_path) }
      it { should_not have_link('Sign in',  href: signin_path) }
      
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end
  end
end
