class Question < ActiveRecord::Base

  has_many :answers
  belongs_to :asker, class_name: "User", foreign_key: :user_id

  def self.private_questions(id = nil)
    id ? self.find_by(id: id, private: false) : self.where(private: false)
  end

end
