require 'rails_helper'

RSpec.feature 'User Post Index', type: :feature do
  let(:user) do
    User.create(name: 'User1', photo: 'https://free-url-shortener.rb.gy/url-shortener.png', posts_counter: 0,
                bio: 'User bio')
  end
  let!(:posts) do
    [
      Post.create(author: user, title: 'First Post', text: 'post1', comments_counter: 2, likes_counter: 3)
    ]
  end
  let!(:comment) do
    Comment.create(author: user, post: posts[0], text: 'First Comment Text')
  end
  let!(:likes) do
    Like.create(author: user, post: posts[0])
  end
  scenario 'viewing the user post index page' do
    visit user_posts_path(user)
    expect(page).to have_css("img[alt='User1']", count: 1)
    expect(page).to have_content('User1')
    expect(page).to have_content('Number of posts 1')
    expect(page).to have_content('First Post')
    expect(page).to have_content('post1')
    expect(page).to have_content('First Comment Text')
    expect(page).to have_content('Comments: 1')
    expect(page).to have_content('Likes: 1')
    expect(page).to have_css('.paginate-container')
    click_link 'First Post'
    expect(current_path).to eq(user_post_path(user, posts[0]))
  end
end
