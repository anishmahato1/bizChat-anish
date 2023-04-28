class User < ApplicationRecord
  # default_scope { includes(avatar_attachment: :blob) }

  enum gender: { male: 0, female: 1, other: 2 }

  # association macros
  has_many :user_chats, dependent: :destroy
  has_many :chats, through: :user_chats

  has_many :channels, -> { includes(:chat) }, through: :chats
  has_one_attached :avatar, dependent: :destroy do |attachable|
    attachable.variant :thumb, resize_to_limit: [120, 150]
    attachable.variant :small, resize_to_limit: [60, 60]
  end

  # scopes
  scope :except_current_user, ->(user) { where.not(id: user.id) }

  # validations macros
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, if: :domain_is_ok
  validates :name, presence: true, format: { with: /\A[a-zA-Z ]+\z/, message: 'only allows letters and spaces' }
  validates :gender, presence: true, inclusion: { in: User.genders.keys }

  # callbacks
  before_validation :squish_name_and_email_spaces
  after_commit :add_default_avatar, on: :update

  # devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  # method to retrieve inboxes
  def self.inboxes(current_user)
    current_user.chats.private_chats.includes({ users: { avatar_attachment: :blob } },
                                              :last_message)
                .filter_current_user(current_user).where.not(last_message_id: nil)
  end

  # methods for ransack gem
  def self.ransackable_attributes(_auth_object = nil)
    %w[name email]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end

  # to raise exception related to authorization
  class NotAuthorized < StandardError
  end

  private

  # method to check subdomain of registering user
  def domain_is_ok
    return if Rails.application.config.approved_domains.any? { |word| email.end_with?(word) }

    errors.add(:email, 'is not from a valid domain')
  end

  # method to strip white spaces at ends and any extras in between
  def squish_name_and_email_spaces
    [name, email].each { |attr| attr.squish! if attr.present? }
  end

  # method to load default avatar
  def add_default_avatar
    return if avatar.attached?

    avatar.attach(
      io: File.open(Rails.root.join('app', 'assets', 'images', 'default_avatar.jpg')),
      filename: 'default_avatar.jpg',
      content_type: 'image/jpg'
    )
  end
end
