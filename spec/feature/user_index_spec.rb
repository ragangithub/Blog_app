require 'rails_helper'
RSpec.describe 'User Index Page', type: :system do
  before do
    @user1 = User.create(name: 'Ragan', posts_counter: 0)
    @user2 = User.create(name: 'Alemu', posts_counter: 0)
    @user1.update(photo: 'https://unsplash.com/photos/F_-0BxGuVvo')
    @user2.update(photo: 'https://unsplash.com/es/fotos/mEZ3PoFGs_k')
  end
  it 'displays the username of all other users' do
    visit users_path
    expect(page).to have_content('Ragan')
    expect(page).to have_content('Alemu')
  end
  it 'displays the profile picture for each user' do
    visit users_path
    expect(page).to have_css('.user-photo')
    expect(page).to have_css('.user-photo')
  end
  it 'displays the number of posts each user has written' do
    visit users_path
    expect(page).to have_content("Number of posts: #{@user1.posts_counter}")
    expect(page).to have_content("Number of posts: #{@user2.posts_counter}")
  end
  it 'When I click on a user, I am redirected to that user show page.' do
    visit user_path(@user1)
    expect(current_path).to eq(user_path(@user1))
  end
end
