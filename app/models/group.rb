module Admin
  class Group < ApplicationRecord
    belongs_to :user
    has_and_belongs_to_many :users
    has_many :messages, dependent: :destroy
  
    validates :name, presence: true
    validates :description, presence: true
  end
end