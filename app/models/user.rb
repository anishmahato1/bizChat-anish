class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  enum gender: { male: 0, female: 1, other: 2 }

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, if: :domain_check 

  private

  def domain_check
    return if Rails.application.config.approved_domains.any? { |word| email.end_with?(word) }

    errors.add(:email, 'is not from a valid domain')
  end
end
