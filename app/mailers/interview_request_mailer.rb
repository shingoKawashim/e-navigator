class InterviewRequestMailer < ApplicationMailer
  default from: ENV['GMAIL_ADDRESS']
  add_template_helper(ActionView::Helpers::UrlHelper)

  def send_request_to_mentor(mentor, student)
    @mentor = mentor
    @student = student
    mail(
      subject: "#{@student.name}さんから面談日申請が行われました。",
      to: @mentor.email
    ) do |format|
      format.text
    end
  end

  def send_remind_to_student(mentor, student)
    @mentor = mentor
    @student = student
    mail(
      subject: "#{@mentor.name}さんに面談日申請を行いました。",
      to: @student.email
    ) do |format|
      format.text
    end
  end
end
