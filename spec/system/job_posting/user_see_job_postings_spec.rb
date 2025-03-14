require 'rails_helper'

describe "User see job postings", type: :system do
  it "that are published and archived", js: true do
    first_user = create(:user, email_address: 'first@email.com')
    first_company = create(:company_profile, user: first_user, contact_email: 'first@company.com')
    rails_job = create(:job_posting, title: "Ruby on Rails Dev Jr.", status: :posted, company_profile: first_company)
    node_job = create(:job_posting, title: "Node Dev Jr.", status: :archived, company_profile: first_company)
    second_user = create(:user, email_address: 'second@email.com')
    second_company = create(:company_profile, user: second_user, contact_email: 'second@company.com')
    django_job = create(:job_posting, title: "Django Dev Jr.", status: :posted, company_profile: second_company)

    login_as first_user
    visit root_path

    expect(page).to have_content rails_job.title
    expect(page).to have_selector("#job_posting_#{node_job.id}")
    within("#job_posting_#{node_job.id}") do
      expect(page).to have_content node_job.title
      expect(page).to have_content 'Arquivado'
    end
    expect(page).to have_content django_job.title
  end
end
