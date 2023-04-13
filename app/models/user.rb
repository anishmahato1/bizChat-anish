class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  enum gender: { male: 0, female: 1, other: 2 }

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, if: :domain_is_ok
  validates :name, presence: true, format: { with: /\A[a-zA-Z ]+\z/, message: 'only allows letters and spaces' }
  validates :gender, presence: true, inclusion: { in: User.genders.keys }

  private

  def domain_is_ok
    return if Rails.application.config.approved_domains.any? { |word| email.end_with?(word) }

    errors.add(:email, 'is not from a valid domain')
  end
end
