require 'rails_helper'

RSpec.describe 'User Show Page', type: :system do
  before do
    @user1 = User.create(name: 'Ragan', posts_counter: 0)
    @user2 = User.create(name: 'Alemu', posts_counter: 0)

    @user1.update(photo: 'https://unsplash.com/photos/F_-0BxGuVvo')
    @user2.update(photo: 'https://unsplash.com/es/fotos/mEZ3PoFGs_k')
  end

  it 'displays the username of the user' do
    visit user_path(@user1)
    expect(page).to have_content('Ragan')
  end

  it 'displays the profile picture of the user' do
    visit user_path(@user1)

    expect(page).to have_css('.user-photo')
  end

  it 'displays the number of posts the user has written' do
    visit user_path(@user1)
    expect(page).to have_content("Number of posts: #{@user1.posts_counter}")
  end

  it 'should show the bio of the user' do
    visit user_path(@user1)
    expect(page).to have_content(@user1.bio)
  end

  it 'should see a button that lets me view all of a user\'s posts' do
    visit user_path(@user1)
    expect(page).to have_content('See all posts')
  end

  it 'I can see the user first 3 posts.' do
    visit user_path(@user1)

    expect(page).to_not have_content('Total number of posts: 4')
  end

  it 'redirects to the posts show page when clicking on a user' do
    visit users_path
    click_link @user1.name
    expect(page).to have_content(@user1.name)
  end

  it "When I click   click to see all posts, it redirects me to the user's post's index page" do
    visit user_path(@user1)
    click_button('See all posts')
    expected_path = user_posts_path(@user1)
    expect(page).to have_current_path(expected_path)
  end
end
