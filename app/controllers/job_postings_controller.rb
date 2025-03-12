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

  def new
    @job_posting = JobPosting.new
  end

  def create
    @job_posting = JobPosting.new(job_posting_params)
    @job_posting.company_profile = Current.user.company_profile
    if @job_posting.save
      redirect_to root_path, notice: t(".success")
    else
      flash[:alert] = t(".failure")
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_job_posting
    @job_posting = JobPosting.find(params[:id])
  end

  def job_posting_params
    params.require(:job_posting).permit(:title, :salary, :salary_currency, :salary_period, :work_arrangement, :job_location, :job_type_id, :experience_level_id, :description)
  end
end
