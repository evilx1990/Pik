class FeedbacksController < ApplicationController

  def new
    @feedback = Feedback.new
    if user_signed_in?
      @feedback.email_author = current_user.email
      @feedback.name = current_user.username
    end
  end

  def create
    @feedback = Feedback.new(feedback_param)

    if verify_recaptcha
      @feedback.save
      flash[:notice] = t('feedback.flash.successful')
    else
      flash[:alert] = t('recaptcha_fail')
    end

    redirect_to new_feedback_path
  end

  private

  def feedback_param
    params.require(:feedback).permit(:email_author, :feedback)
  end
end
