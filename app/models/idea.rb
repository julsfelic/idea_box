class Idea < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true, length: { maximum: 100 }
end
