require 'rails_helper'

RSpec.describe 'Post Index Page', type: :system do
  before do
    @user = User.create(name: 'John Doe', photo: 'https://example.com/john_doe.jpg')
    @post1 = Post.create(title: 'Post 1', text: 'Lorem ipsum dolor sit amet...', author: @user, comments_counter: 0,
                         likes_counter: 0)
    @post2 = Post.create(title: 'Post 2', text: 'Consectetur adipiscing elit...', author: @user, comments_counter: 0,
                         likes_counter: 0)
  end

  it 'displays the user photo  for each post' do
    visit user_posts_path(@user)
    expect(page).to have_css('.user-photo')
  end

  it 'displays the username for each post' do
    visit user_posts_path(@user)
    expect(page).to have_content('John Doe', count: 1)
  end

  it 'displays the title and preview text of each post' do
    visit user_posts_path(@user)

    expect(page).to have_content('Post 1')
    expect(page).to have_content('Post 2')
    expect(page).to have_content('Lorem ipsum dolor sit amet...', count: 1)
  end

  it 'displays the number of comments  for each post' do
    visit user_posts_path(@user)
    expect(page).to have_content('Comments: 0', count: 2)
  end

  it 'displays the number of  likes for each post' do
    visit user_posts_path(@user)
    expect(page).to have_content('Likes: 0', count: 2)
  end

  it 'displays the five most recent comments for each post' do
    Comment.create(text: 'Comment 1', post: @post1, author: @user)
    Comment.create(text: 'Comment 2', post: @post1, author: @user)
    Comment.create(text: 'Comment 3', post: @post1, author: @user)
    Comment.create(text: 'Comment 4', post: @post2, author: @user)
    Comment.create(text: 'Comment 5', post: @post2, author: @user)
    Comment.create(text: 'Comment 6', post: @post2, author: @user)
    Comment.create(text: 'Comment 6', post: @post2, author: @user)

    visit user_posts_path(@user)

    expect(page).to have_content('Comment 1', count: 1)
    expect(page).to have_content('Comment 2', count: 1)
    expect(page).to have_content('Comment 3', count: 1)
    expect(page).to have_content('Comment 4', count: 1)
    expect(page).to have_content('Comment 5', count: 1)
    expect(page).not_to have_content('Comment 7')
  end

  it 'displays a message when there are no posts for the user' do
    @user.posts.destroy_all
    visit user_posts_path(@user)
    expect(page).to have_content('No posts for this user!')
  end

  it 'I can see a section for pagination if there are more posts than fit on the view.' do
    visit user_posts_path(@user)
    page.has_button?('Pagination')
  end

  it 'redirects to the post show page when clicking on a post' do
    visit user_posts_path(@user)

    first('.post-item').click
    expect(page).to have_current_path(user_post_path(@user, @post1))
  end
end
