class InterviewDecorator < Draper::Decorator
  delegate_all

  def show_date
    start_date.strftime("%Y年%m月%d日 %H時%M分〜")
  end

  def mentor_name
    User.find(mentor_id).name if mentor_id
  end


  class << self
    def header_objects
      model = eval(self.model_name.name.camelize)
      [
        model.human_attribute_name(:start_date),
        model.human_attribute_name(:status),
        model.human_attribute_name(:mentor_id),
      ]
    end

    def body_objects
      [
        "show_date",
        "status_i18n",
        "mentor_name",
      ]
    end
  end
end
