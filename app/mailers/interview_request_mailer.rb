class InterviewRequestMailer < ApplicationMailer
  default from: ENV['GMAIL_ADDRESS']
  add_template_helper(ActionView::Helpers::UrlHelper)

  def send_request_to_mentor(info)
    @mentor = info[0]
    @student = info[1]
    mail(
      subject: "#{@student.name}さんから面談日申請が行われました。",
      to: @mentor.email
    ) do |format|
      format.text
    end
  end

  def send_remind_to_student(info)
    @mentor = info[0]
    @student = info[1]
    mail(
      subject: "#{@mentor.name}さんに面談日申請を行いました。",
      to: @student.email
    ) do |format|
      format.text
    end
  end
end
