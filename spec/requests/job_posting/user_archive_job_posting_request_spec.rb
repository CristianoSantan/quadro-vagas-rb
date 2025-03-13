require 'rails_helper'

describe 'User tries to archive a job posting', type: :request do
  it 'and fails for not being authenticated' do
    post(archive_job_posting_path(id: 1))

    expect(response).to redirect_to new_session_path
    expect(response.status).to eq 302
  end

  it 'and repost fails for not being authenticated' do
    post(post_job_posting_path(id: 1))

    expect(response).to redirect_to new_session_path
    expect(response.status).to eq 302
  end
end
