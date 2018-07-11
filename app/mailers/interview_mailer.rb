class InterviewMailer < ApplicationMailer
  default from: ENV['GMAIL_ADDRESS']
  add_template_helper(ActionView::Helpers::UrlHelper)

  def apply_to_mentor(mentor, student)
    @mentor = mentor
    @student = student
    mail(
      subject: "#{@student.name}さんから面談日申請が行われました。",
      to: @mentor.email
    ) do |format|
      format.text
    end
  end

  def apply_to_student(mentor, student)
    @mentor = mentor
    @student = student
    mail(
      subject: "#{@mentor.name}さんに面談日申請を行いました。",
      to: @student.email
    ) do |format|
      format.text
    end
  end

  def approval_to_student(mentor, student, interview)
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

  def approval_to_mentor(mentor, student, interview)
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
