class Post < ActiveRecord::Base

  credentials = {
    :bucket => 'doppelgrammer',
    :access_key_id => Rails.application.secrets.s3_access_key_id,
    :secret_access_key => Rails.application.secrets.s3_secret_access_key_id
  }

  has_and_belongs_to_many :tags
  has_many :votes
  has_attached_file :picture1, styles: {medium: "300x300#"}, :storage => :s3,
    :s3_credentials => credentials

  validates_attachment_content_type :picture1, :content_type => /\Aimage\/.*\Z/
  validates :picture1, presence: true

  has_attached_file :picture2, styles: {medium: "300x300#"}, :storage => :s3,
    :s3_credentials => credentials
    
  validates_attachment_content_type :picture2, :content_type => /\Aimage\/.*\Z/
  validates :picture2, presence: true

  validates :caption1, presence: true,
            length: {maximum: 30, too_long: "Sorry your caption is too long"},
            format: { with: /^[A-Za-z\d\s]+$/, :multiline => true, message: "Only numbers, letters and spaces allowed" } 
  validates :caption2, presence: true,
            length: {maximum: 30, too_long: "Sorry your caption is too long"},
            format: { with: /^[A-Za-z\d\s]+$/, :multiline => true, message: "Only numbers, letters and spaces allowed" }

  def create_tags
    tag1 = '#' + caption2.downcase.delete(' ')
    tag2 = '#' + caption1.downcase.delete(' ')
    self.tags << Tag.find_or_create_by(text: tag1)
    self.tags << Tag.find_or_create_by(text: tag2)
  end

  def count_upvotes
    self.votes.select { |vote| vote.direction == "up" }.count
  end

  def count_downvotes
    self.votes.select { |vote| vote.direction == 'down' }.count
  end

  def count_netvotes
    self.count_upvotes - self.count_downvotes
  end

end
