require 'rails_helper'
RSpec.feature 'Post Show Page', type: :feature do
  let(:user) do
    User.create(name: 'User1', photo: 'https://free-url-shortener.rb.gy/url-shortener.png', posts_counter: 0,
                bio: 'User bio')
  end
  let(:post) do
    Post.create(author: user, title: 'Sample Post Title', text: 'This is the post body text.', comments_counter: 2,
                likes_counter: 3)
  end
  let!(:comments) do
    [
      Comment.create(author: user, post:, text: 'First Comment Text'),
      Comment.create(author: user, post:, text: 'Second Comment Text')
    ]
  end
  scenario 'viewing the post show page' do
    visit user_post_path(user, post)
    expect(page).to have_content('Sample Post Title')
    expect(page).to have_content("by #{user.name}")
    expect(page).to have_content('Comments: 2')
    expect(page).to have_content('Likes: 3')
    expect(page).to have_content('This is the post body text.')
    comments.each do |comment|
      expect(page).to have_content(comment.author.name)
      expect(page).to have_content(comment.text)
    end
  end
end