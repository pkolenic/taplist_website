require 'spec_helper'

describe "StaticPages" do
  
  let(:base_title) { "TapList" }
  
  subject { page }
  
  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(page_title)) }
  end
  
  describe "Home page" do
    before { visit root_path }

    it { should_not have_selector('h1', text: 'TapList') }
    it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }
  end

  describe "Help page" do
    before { visit help_path }
    let(:heading)     { 'Help' }
    let(:page_title)  { 'Help' }
    
    it_should_behave_like "all static pages"
  end
  
  describe "Contact page" do
    before { visit contact_path }
    let(:heading)     { 'Contact Us' }
    let(:page_title)  { 'Contact Us' }
    
    it_should_behave_like "all static pages"
  end
  
  it "should have the right links on the layout" do
    visit root_path
    
    click_link "Help"
    expect(page).to have_title(full_title('Help'))
    
    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))
    
    click_link "logo"
    expect(page).to have_title(full_title(''))
    
    click_link "Sign up!"
    expect(page).to have_title(full_title('Sign up'))
  end
end