class JobPostingsController < ApplicationController
  allow_unauthenticated_access only: [ :show ]
  before_action :set_job_posting, only: [ :show, :archive ]

  def show; end

  def archive
    if @job_posting.company_profile.user == Current.user
      @job_posting.update(status: :archived)
      redirect_to job_posting_path(@job_posting), notice: "Vaga arquivada com sucesso."
    else
      redirect_to job_posting_path(@job_posting), alert: "Você não tem permissão para arquivar esta vaga."
    end
  end

  private

  def set_job_posting
    @job_posting = JobPosting.find(params[:id])
  end
end
