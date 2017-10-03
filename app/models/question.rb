class Question < ActiveRecord::Base

  has_many :answers
  belongs_to :asker, class_name: "User", foreign_key: :user_id

end
