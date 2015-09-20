class Pin < ActiveRecord::Base
   belongs_to :user
   acts_as_votable
   has_attached_file :image,
                     :style => { :medium => "300x300>", :thumb => "100x100>" },
                     :storage => :s3,
                     :bucket  => ENV['MY_BUCKET_NAME']
   validates :image, presence: true
   validates :description, presence: true
end

