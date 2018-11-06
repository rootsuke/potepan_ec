require 'rails_helper'

RSpec.feature "Potepan::Index", type: :feature do
  scenario "render successfully" do
    visit potepan_root_path
    click_link "Home"
    expect(page).to have_title "BIGBAG Store"
    expect(current_path).to eq potepan_index_path
  end
end
