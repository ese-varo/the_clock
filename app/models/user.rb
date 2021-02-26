class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  has_many :timezones, dependent: :destroy
  has_many :stopwatches, dependent: :destroy
  has_many :alarms, dependent: :destroy
end
