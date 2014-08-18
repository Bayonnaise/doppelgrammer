class Post < ActiveRecord::Base

	has_attached_file :picture1, styles: {medium: "220x220#"}
  validates_attachment_content_type :picture1, :content_type => /\Aimage\/.*\Z/

  has_attached_file :picture2, styles: {medium: "220x220#"}
  validates_attachment_content_type :picture2, :content_type => /\Aimage\/.*\Z/
end
