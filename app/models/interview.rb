class Interview < ApplicationRecord
  belongs_to :user

  enum status: { withhold: 0, reject: 1, approval: 2 }

  validates :user_id, presence: true
  validates :start_date, presence: true

  def show_date
    self.start_date.strftime("%Y年%m月%d日 %H時%M分〜")
  end

  def mentor_name
    User.find(self.mentor_id).name
  end

  class << self
    def alive_future_records
      alive_records.where("start_date >= ?", Date.today).order(id: :asc)
    end
  end
end
