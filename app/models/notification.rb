class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject, polymorphic: true

  scope :recent, -> { where('read_at IS NULL AND ignored_at IS NULL AND cancelled_at IS NULL').order('id DESC').limit(3) }

  before_validation :set_email
  before_validation :set_token

  validates :email, presence: true, if: :deliver_via_email?
  validates :email_from, presence: true, if: :deliver_via_email?
  validates :email_subject, presence: true, if: :deliver_via_email?

  def click
    return false if self.cancelled?
    self.click_count += 1
    self.clicked_at ||= Time.now
    self.save
  end

  def read
    return false if self.cancelled?
    self.read_count += 1
    self.read_at ||= Time.now
    self.save
  end

  def ignore
    return false if self.cancelled?
    self.ignored_at ||= Time.now
    self.save
  end

  def cancel
    return true if self.cancelled_at.present?
    self.update_attribute(:cancelled_at, Time.now)
  end

  def cancelled?
    self.cancelled_at.present?
  end

  def unsubscribe
    self.unsubscribed_at ||= Time.now
    self.save
  end

  def deliver
    return if self.email_sent_at.present? || !self.deliver_via_email?

    NotificationsMailer.notify(self.id).deliver
  end

  def to_param
    self.token
  end

  protected

  def set_email
    return if !self.deliver_via_email?

    self.email ||= self.user.try(:email) rescue nil
  end

  # The default size is 16 which is 1/64^16, this is protected by
  # a unique index in the database to absolutely prevent collisions
  def set_token
    self.token ||= SecureRandom.urlsafe_base64(16)
  end
end

# == Schema Information
#
# Table name: notifications
#
#  id                      :integer          not null, primary key
#  category                :string
#  promotional             :boolean          default(FALSE)
#  transactional           :boolean          default(TRUE)
#  do_not_track            :boolean          default(FALSE)
#  deliver_via_site        :boolean          default(TRUE)
#  deliver_via_email       :boolean          default(TRUE)
#  kind                    :string
#  token                   :string
#  user_id                 :integer
#  subject_id              :integer
#  subject_type            :string
#  read_at                 :datetime
#  clicked_at              :datetime
#  ignored_at              :datetime
#  cancelled_at            :datetime
#  unsubscribed_at         :datetime
#  email_sent_at           :datetime
#  email_marked_as_spam_at :datetime
#  email_returned_at       :datetime
#  email_not_sent_at       :datetime
#  email_not_sent_reason   :string
#  email                   :string
#  email_reply_to          :string
#  email_from              :string
#  email_subject           :string
#  email_urls              :text
#  email_text              :text
#  email_html              :text
#  click_count             :integer          default(0)
#  read_count              :integer          default(0)
#  data                    :text
#  created_at              :datetime
#  updated_at              :datetime
#
