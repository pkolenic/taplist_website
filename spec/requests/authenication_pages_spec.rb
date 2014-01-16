require 'spec_helper'

describe "Authenication" do
  
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
      
      it { should_not have_link('Users') }
      it { should_not have_link('Profile') }
      it { should_not have_link('Settings') }
      it { should_not have_link('Sign out',    href: signout_path) }
      it { should have_link('Sign in', href: signin_path) }      
    end # describe "with invalid information"
    
    describe "with valid information" do
      let(:user)    { FactoryGirl.create(:user) }
      before { sign_in user }
      
      it { should have_title(user.full_name) }
      it { should have_link('Users',        href: users_path) }
      it { should have_link('Profile',      href: user_path(user)) }
      it { should have_link('Settings',     href: edit_user_path(user)) }
      it { should have_link('Sign out',     href: signout_path) }
      it { should_not have_link('Sign in',  href: signin_path) }
      
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end
  end # describe "with valid information"
  
  describe "authorization" do        
    describe "for non-signed-in users" do
      let(:user)    { FactoryGirl.create(:user) }
    
      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          valid_signin(user)
        end

        describe "after signing in" do
          it "should render the desired protected page" do
            expect(page).to have_title('Edit user')
          end
          
          describe "when signing in again" do
            before do
              delete signout_path
              visit signin_path
              valid_signin(user)
            end

            it "should render the default (profile) page" do
              expect(page).to have_title(user.full_name)
            end
          end           
        end
      end
      
      describe "in the Users Controller" do
        
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }
        end
        
        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end
        
        describe "visiting the user index" do
          before { visit users_path }
          it { should have_title('Sign in') }
        end
        
      end # describe "in the Users Controller"
    end # describe "for non-signed-in users"    
    
    describe "as signed in user" do
      let(:user)          { FactoryGirl.create(:user) }
      before { sign_in user, no_capybara:true }
      
      describe "submitting a Post request to the User#create action" do
        before  do
          user_params = {user: {first_name: "Example", last_name: "User", email: "user@example.com",
                           password: "foobar", password_confirmation: "foobar" }} 
          post users_path user_params
        end
        specify { expect(response).to redirect_to(root_url) }
      end
    end
    
    describe "as wrong user" do
      let(:user)        { FactoryGirl.create(:user) }
      let(:wrong_user)  { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user, no_capybara:true }
      
      describe "submitting a GET request to the Users#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Edit user')) }
        specify { expect(response).to redirect_to(root_url) }
      end
      
      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end # describe "as wrong user"  
    
    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin, no_capybara: true }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end  # describe "as non-admin user"     
    
    describe "as admin deleting self" do
      let(:user) { FactoryGirl.create(:admin) }
      
      before { sign_in user, no_capybara: true }
      describe "submitting a DELETE request to the Users#destroy action" do
        specify {        
          expect do
            delete user_path(user)
          end.to change(User, :count).by(0)
        }
      end      
    end # describe "as admin deleting self"
  end # describe "authorization" 
  
end #describe "Authenication"
