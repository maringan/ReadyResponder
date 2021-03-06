require 'rails_helper'

RSpec.describe "a user in the trainer role" do
  before (:each) do
    @person = create(:person)
    sign_in_as('Trainer')
  end

  it "cannot edit people" do
    visit edit_person_path(@person)
    expect(page).to have_content("Access Denied")
  end
  it "cannot create a new person" do
    visit people_path
    expect(page).not_to have_content('Create')
    visit new_person_path
    expect(page).to have_content("Access Denied")
  end
  it "can read a person" do
    visit people_path
    click_on @person.lastname
    expect(page).to have_content(@person.lastname)
  end
  it "get a signin sheet when requested" do
    @person_active = create(:person)
    @person_inactive = create(:person, status: 'Inactive')
    visit signin_people_path
    expect(page).to have_content("Command") #This is in the first heading
    expect(page).to have_content(@person_active.lastname)
    expect(page).not_to have_content(@person_inactive.lastname)
  end
  it "can add a certification" do
    visit person_path(@person)
    expect(find('#sidebar')).to have_link('New Certification')
  end
end
