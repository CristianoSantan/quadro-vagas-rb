require 'rails_helper'

describe "User archive a job posting", type: :system do
  it "successfuly" do
    first_user = create(:user, email_address: 'first@email.com')
    first_company = create(:company_profile, user: first_user, contact_email: 'first@company.com')
    rails_job = create(:job_posting, title: "Ruby on Rails Dev Jr.", status: :posted, company_profile: first_company)
    second_user = create(:user, email_address: 'second@email.com')
    second_company = create(:company_profile, user: second_user, contact_email: 'second@company.com')
    django_job = create(:job_posting, title: "Django Dev Jr.", status: :posted, company_profile: second_company)

    login_as second_user
    visit root_path
    click_link 'Django Dev Jr.'
    click_button 'Arquivar'

    job = JobPosting.last
    expect(job.status).to eq 'archived'
    expect(page).to have_content "Vaga arquivada com sucesso"
    expect(page).to have_button "Postar"
    expect(page).not_to have_button "Arquivar"
  end

  it "and is not the owner" do
    first_user = create(:user, email_address: 'first@email.com')
    first_company = create(:company_profile, user: first_user, contact_email: 'first@company.com')
    rails_job = create(:job_posting, title: "Ruby on Rails Dev Jr.", status: :posted, company_profile: first_company)
    second_user = create(:user, email_address: 'second@email.com')
    second_company = create(:company_profile, user: second_user, contact_email: 'second@company.com')
    django_job = create(:job_posting, title: "Django Dev Jr.", status: :posted, company_profile: second_company)

    login_as second_user
    visit root_path
    click_link 'Ruby on Rails Dev Jr.'

    expect(page).not_to have_button "Arquivar"
    expect(page).not_to have_button "Postar"
  end

  it "and post again" do
    first_user = create(:user, email_address: 'first@email.com')
    first_company = create(:company_profile, user: first_user, contact_email: 'first@company.com')
    rails_job = create(:job_posting, title: "Ruby on Rails Dev Jr.", status: :archived, company_profile: first_company)

    login_as first_user
    visit root_path
    click_link 'Ruby on Rails Dev Jr.'
    click_button 'Postar'

    job = JobPosting.last
    expect(job.status).to eq 'posted'
    expect(page).to have_content "Vaga publicada com sucesso"
    expect(page).to have_button "Arquivar"
    expect(page).not_to have_button "Postar"
  end
end
