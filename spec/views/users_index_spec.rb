require 'rails_helper'

RSpec.feature 'User Index', type: :feature do
  scenario 'visiting the user index page' do
    User.create(name: 'User1', photo: 'https://free-url-shortener.rb.gy/url-shortener.png',
                posts_counter: 0)
    User.create(name: 'User2', photo: 'https://free-url-shortener.rb.gy/url-shortener.png',
                posts_counter: 0)

    visit users_path

    expect(page).to have_content('User1')
    expect(page).to have_content('User2')
    expect(page).to have_css("img[alt='User1']", count: 1)
    expect(page).to have_css("img[alt='User2']", count: 1)
  end

  scenario 'visiting the user index page, you see the number of posts each user has written..' do
    user1 = User.create(name: 'User1',
                        photo: 'https://free-url-shortener.rb.gy/url-shortener.png', posts_counter: 0)
    user2 = User.create(name: 'User2',
                        photo: 'https://free-url-shortener.rb.gy/url-shortener.png', posts_counter: 0)
    Post.create(author: user1, title: 'first post', comments_counter: 0, likes_counter: 0)
    Post.create(author: user2, title: 'second post', comments_counter: 0, likes_counter: 0)
    Post.create(author: user2, title: 'third post', comments_counter: 0, likes_counter: 0)

    visit users_path

    expect(page).to have_content('1')
    expect(page).to have_content('2')
  end

  scenario 'clicking on a user redirects to their show page' do
    user = User.create(name: 'User1',
                       photo: 'https://free-url-shortener.rb.gy/url-shortener.png', posts_counter: 0)

    visit users_path

    click_link 'User1'

    expect(current_path).to eq(user_path(user))
  end
end
