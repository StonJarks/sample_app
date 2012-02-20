require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: "Ruby on Rails Tutorial Sample App | ") }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading)    { 'Sample App' }
    let(:page_title) { 'Home' }

    it_should_behave_like "all static pages"

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit  amet")
        sign_in(user)
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("tr##{item.id}", text: item.content)
        end
      end
    end
  end


  describe "Help page" do
    before { visit root_path }
    let(:heading)    { 'Sample App' }
    let(:page_title) { 'Help' }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit root_path }
    let(:heading)    { 'Sample App' }
    let(:page_title) { 'About us' }

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit root_path }
    let(:heading)    { 'Sample App' }
    let(:page_title) { 'Contact' }

    it_should_behave_like "all static pages"
  end

it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: 'About us'
    click_link "Help"
    page.should have_selector 'title', text: 'Help'
    click_link "Contact"
    page.should have_selector 'title', text: 'Contact'
    click_link "Home"
    page.should have_selector 'title', text: 'Home'
    click_link "Sign up now"
    page.should have_selector 'title', text: 'Sign up'
  end
end