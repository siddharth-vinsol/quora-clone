class AbuseReportsController < ApplicationController
  before_action :set_reportable
  before_action :check_already_reported
  
  def new
    @abuse_report = AbuseReport.new
  end

  def create
    @abuse_report = @reportable.abuse_reports.build(abuse_report_params)
    @abuse_report.user = current_user

    if @abuse_report.save
      redirect_to profile_path, notice: t('submit_success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private def set_reportable
    @reportable = params[:reportable_type].constantize.find(params[:reportable_id])
  end

  private def abuse_report_params
    params.require(:abuse_report).permit(:reason)
  end

  private def check_already_reported
    if @abuse_report = @reportable.abuse_reports.find_by(user_id: current_user.id)
      redirect_to request.referrer, notice: t('already_reported', abuse_report_time: @abuse_report.created_at.to_date)
    end
  end
end
