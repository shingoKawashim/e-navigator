class UserDecorator < Draper::Decorator
  delegate_all

  def birthday_human
    "不明" unless birthday
    "#{birthday} (#{age}歳)"
  end

  def age
    "-" unless birthday
    date_format = "%Y%m%d"
    (Date.today.strftime(date_format).to_i - birthday.strftime(date_format).to_i) / 10000
  end

  def user_type_badge
    if student?
      "<span class='badge badge-success'>生徒</span>".html_safe
    else
      "<span class='badge badge-danger'>面接官</span>".html_safe
    end
  end

  class << self
    def header_objects
      model = eval(self.model_name.name.camelize)
      [
        model.human_attribute_name(:name),
        model.human_attribute_name(:sex),
        model.human_attribute_name(:birthday),
        model.human_attribute_name(:school),
        model.human_attribute_name(:email),
      ]
    end

    def body_objects
      [
        "name",
        "sex_i18n",
        "birthday_human",
        "school",
        "email",
      ]
    end

    def bd_count
      50
    end

  end
end
