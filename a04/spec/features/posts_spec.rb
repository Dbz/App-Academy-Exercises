require 'rails_helper'

feature "Creating a post" do
  context "when logged in" do
    before :each do
      sign_up_as_jack_bruce
      visit '/posts/new'
    end

    it "has a new post page" do
      expect(page).to have_content 'New Post'
    end

    it "takes a title and a body" do
      expect(page).to have_content 'Title'
      expect(page).to have_content 'Body'
    end

    it "validates the presence of title and body" do
      fill_in 'Body', with: 'La di da'
      click_button 'Create New Post'
      expect(page).to have_content 'New Post'
    end

    it "redirects to the post show page" do
      make_post
      expect(page).to have_content 'My First Post'
    end

    context "on failed save" do
      before :each do
        make_post("", "La di da")
      end

      it "displays the new post form again" do
        expect(page).to have_content 'New Post'
      end

      it "has a pre-filled form (with the data previously input)" do
        expect(find_field('Body').value).to eq('La di da')
      end

      it "still allows for a successful save" do
        fill_in 'Title', with: 'My First Post'
        click_button 'Create New Post'
        expect(page).to have_content 'My First Post'
      end
    end
  end

  context "when logged out" do
    it "redirects to the login page" do
      visit '/posts/new'
      expect(page).to have_content 'Sign In'
    end
  end
end

feature "Seeing all posts" do
  context "when logged in" do
    before :each do
      sign_up_as_jack_bruce
      make_post('My First Post')
      make_post('My Second Post')
      visit '/posts'
    end

    it "shows all the posts for the current user" do
      expect(page).to have_content 'My First Post'
      expect(page).to have_content 'My Second Post'
    end

    it "shows the current user's username" do
      expect(page).to have_content 'jack_bruce'
    end

    it "links to each of the posts with the post titles" do
      click_link 'My First Post'
      expect(page).to have_content 'My First Post'
      expect(page).to_not have_content('My Second Post')
    end
  end

  context "when logged out" do
    it "redirects to the login page" do
      visit '/posts'
      expect(page).to have_content 'Sign In'
    end
  end

  context "when signed in as another user" do
    before :each do
      sign_up('jack_bruce')
      click_button 'Sign Out'
      sign_up('goodbye_world')
      make_post('Goodbye cruel world')
      click_button 'Sign Out'
      sign_in('jack_bruce')
    end

    it "does not show others posts" do
      visit '/posts'
      expect(page).not_to have_content('Goodbye cruel world')
    end
  end
end

feature "Showing a post" do
  context "when logged in" do
    before :each do
      sign_up('jack_bruce')
      make_post('Hello, World!')
      visit '/posts'
      click_link 'Hello, World!'
    end

    it "displays the post title" do
      expect(page).to have_content 'Hello, World!'
    end

    it "displays the post body" do
      expect(page).to have_content 'The body of a post is rad.'
    end

    it "displays the author username" do
      # TODO: this will trivially pass because username is already listed in
      # layout.

      expect(page).to have_content 'jack_bruce'
    end
  end
end

feature "Editing a post" do
  before :each do
    sign_up_as_jack_bruce
    make_post('This is a title')
    visit '/posts'
    click_link 'This is a title'
  end

  it "has a link on the show page to edit a post" do
    expect(page).to have_content 'Edit Post'
  end

  it "shows a form to edit the post" do
    click_link 'Edit Post'
    expect(page).to have_content 'Title'
    expect(page).to have_content 'Body'
  end

  it "has all the data pre-filled" do
    click_link 'Edit Post'
    expect(find_field('Title').value).to eq('This is a title')
    expect(find_field('Body').value).to eq('The body of a post is rad.')
  end

  context "on successful update" do
    before :each do
      @show_page = current_path
      click_link 'Edit Post'
    end

    it "redirects to the post show page" do
      fill_in 'Title', with: 'A new title'
      click_button 'Update Post'
      expect(page).to have_content 'A new title'
      # Disallow creation of a new Post
      expect(current_path).to eq(@show_page)
    end
  end

  context "on a failed update" do
    before :each do
      @show_page = current_path
      click_link 'Edit Post'
    end

    it "returns to the edit page" do
      fill_in 'Title', with: ''
      click_button 'Update Post'

      # failed; should be able to try again
      fill_in 'Title', with: 'Ginger Baker'
      click_button 'Update Post'

      expect(current_path).to eq(@show_page)
      expect(page).to have_content("Ginger Baker")
    end

    it "preserves the attempted updated data" do
      fill_in 'Title', with: ''
      click_button 'Update Post'

      expect(find_field('Title').value).to eq("")
    end
  end
end
