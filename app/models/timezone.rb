class Timezone < ApplicationRecord
  belongs_to :user
  validates :label, presence: true
end
