class User < ApplicationRecord
  validates :uuid, presence: true, uniqueness: true
  validates :name, presence: true
  validates :phone, presence: true
  validates :user_type, presence: true, inclusion: { in: %w[student professor] }  # Ajuste conforme roles

  has_many :logins, dependent: :destroy

  has_many :student_schedulings, class_name: "Scheduling", foreign_key: "student_id", dependent: :destroy
  has_many :professor_schedulings, class_name: "Scheduling", foreign_key: "professor_id", dependent: :destroy
  has_many :course_classes, foreign_key: "professor_id", dependent: :destroy

  before_validation :generate_uuid, on: :create

  private

  def generate_uuid
    self.uuid ||= SecureRandom.uuid
  end
end
