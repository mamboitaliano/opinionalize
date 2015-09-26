class Question < ActiveRecord::Base
  has_many :responses
  belongs_to :survey

  validates :text, presence: true
end
