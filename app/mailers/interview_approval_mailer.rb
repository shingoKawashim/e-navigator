class InterviewApprovalMailer < ApplicationMailer
  default from: ENV['GMAIL_ADDRESS']
  add_template_helper(ActionView::Helpers::UrlHelper)

  def send_approval_to_student(mentor, student, interview)
    @mentor = mentor
    @student = student
    @interview = interview
    mail(
      subject: "#{@mentor.name}さんが面談日を承認しました。",
      to: @student.email
    ) do |format|
      format.text
    end
  end

  def send_remind_to_mentor(mentor, student, interview)
    @mentor = mentor
    @student = student
    @interview = interview
    mail(
      subject: "#{@student.name}さんの面談日を承認しました。",
      to: @mentor.email
    ) do |format|
      format.text
    end
  end
end
