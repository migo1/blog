require 'rails_helper'

RSpec.feature 'User Show Page', type: :feature do
  let(:user) do
    User.create(name: 'User1', photo: 'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png',
                posts_counter: 0, bio: 'User bio')
  end
  let!(:posts) do
    [
      Post.create(author: user, title: 'First Post', text: 'This is the first post', comments_counter: 0,
                  likes_counter: 0),
      Post.create(author: user, title: 'Second Post', text: 'This is the second post', comments_counter: 0,
                  likes_counter: 0),
      Post.create(author: user, title: 'Third Post', text: 'This is the third post', comments_counter: 0,
                  likes_counter: 0)
    ]
  end
  scenario 'viewing the user show page' do
    visit user_path(user)
    expect(page).to have_css("img[alt='User1']", count: 1)
    expect(page).to have_content('User1')
    expect(page).to have_content('Number of posts 3')
    expect(page).to have_content('User bio')
    expect(page).to have_content('First Post')
    expect(page).to have_content('Second Post')
    expect(page).to have_content('Third Post')
    expect(page).to have_link('see all posts', href: user_posts_path(user))
    click_link("Post ##{posts[0].id}", href: user_post_path(user, posts[0]))
    expect(current_path).to eq(user_post_path(user, posts[0]))
    visit user_path(user)
    click_link 'see all posts'
    expect(current_path).to eq(user_posts_path(user))
  end
end
