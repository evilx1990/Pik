ActiveAdmin.register_page "Reply feedback" do
  belongs_to :feedback

  content do
    render 'feedbacks/active_admin/reply_form'
  end

  page_action :send_reply, method: :post do
    feedback = Feedback.find(params[:feedback_id])

    AdminMailer.with(email: feedback.email_author,
                     name: feedback.name,
                     url: request.protocol + request.host,
                     message: params[:reply_feedback][:message]).reply_feedback_email.deliver_later

    feedback.state = true
    feedback.save
    flash[:notice] = 'Response sent successfully'
    redirect_to admin_root_path
  end
end
