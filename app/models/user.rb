class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  before_validation :squish_name_and_email_spaces

  enum gender: { male: 0, female: 1, other: 2 }

  has_many :user_chats
  has_many :chats, through: :user_chats

  has_many :channels, through: :chats
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [120, 150]
    attachable.variant :small, resize_to_limit: [60, 60]
  end

  after_commit :add_default_avatar, on: %i[create update]

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, if: :domain_is_ok
  validates :name, presence: true, format: { with: /\A[a-zA-Z ]+\z/, message: 'only allows letters and spaces' }
  validates :gender, presence: true, inclusion: { in: User.genders.keys }

  def self.ransackable_attributes(_auth_object = nil)
    %w[name email]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end

  private

  def domain_is_ok
    return if Rails.application.config.approved_domains.any? { |word| email.end_with?(word) }

    errors.add(:email, 'is not from a valid domain')
  end

  def squish_name_and_email_spaces
    [name, email].each { |attr| attr.squish! if attr.present? }
  end

  def add_default_avatar
    return if avatar.attached?

    avatar.attach(
      io: File.open(Rails.root.join('app', 'assets', 'images', 'default_avatar.jpg')),
      filename: 'default_avatar.jpg',
      content_type: 'image/jpg'
    )
    
  end
end
