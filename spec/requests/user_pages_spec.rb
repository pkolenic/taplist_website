require 'spec_helper'

describe "UserPages" do
  
  subject { page }
  
  describe "signup page" do
    before { visit signup_path }
    
    it { should have_content('Sign up')}
    it { should have_title(full_title('Sign up')) }
  end
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    
    it { should have_content(user.full_name) }
    it { should have_title(user.full_name) }
  end # describe "profile page"
  
  describe "signup" do
    let(:submit)  { "Create my account" }
    before { visit signup_path }
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "First Name",     with: "Example"
        fill_in "Last Name",      with: "User"
        fill_in "Email",          with: "user@example.com"
        fill_in "Password",       with: "foobar"
        fill_in "Confirmation",   with: "foobar"
      end
      
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
    
  end # describe "signup"
end # describe "User Pages"
