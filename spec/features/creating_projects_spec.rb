require 'spec_helper'

feature 'Creating Project' do 
	scenario "can create a project" do 
		visit '/'
		click_link 'New Porject'

		fill_in 'Name', with: 'TextMate 2'
		fill_in 'Description', with: 'A text-editor for OS X'
		click_button 'Create Project'

		expect(page).to have content('Project has been created.')
	end
end