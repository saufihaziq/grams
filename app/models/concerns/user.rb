class User < ApplicationRecord
	require 'carrierwave/orm/activerecord'
	mount_uploader :avatar, AvatarUploader
	has_many :authentications, :dependent => :destroy

    has_secure_password
    
	validates_presence_of :fullname
	validates_presence_of :email
	validates :password, presence: true, length: { in: 6..20 }
    validate :valid_email
    before_create :valid_email
	
	has_many :posts, dependent: :destroy
	has_many :comments
	has_many :likes
	has_many :buyings
    
	enum gender: [:not_specified, :male, :female]

    # def valid_password
	# 	unless self.password.length >= 6
	# 		errors.add(:password, "length is too short.")
	# 	end
	# end
	
	def valid_email
		unless self.email =~ /\w+@\w+\.\w{2,}/
			errors.add(:email, "is not valid.")
		end
	end

	def self.create_with_auth_and_hash(authentication, auth_hash)
      	create! do |user|
			user.fullname = auth_hash["extra"]["raw_info"]["name"]
      		user.email = auth_hash["extra"]["raw_info"]["email"]
      		user.authentications << (authentication)
			user.password = SecureRandom.hex(7)       
		end
	end

  	def fb_token
    	x = self.authentications.where(:provider => :facebook).first
    	return x.token unless x.nil?
  	end

	filterrific(
 		 default_filter_params: { sorted_by: 'created_at_desc' },
  		 available_filters: [
    	 :sorted_by,
    	 :search_query,
    	]
  	) 

  	scope :sorted_by, lambda { |sort_option|
  		# extract the sort direction from the param value.
    	direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      	# Simple sort on the created_at column.
      	# Make sure to include the table name to avoid ambiguous column names.
      	# Joining on other tables is quite common in Filterrific, and almost
      	# every ActiveRecord table has a 'created_at' column.
      	order("users.created_at #{ direction }")
   	when /^name_/
      	# Simple sort on the name colums
      	order("LOWER(users.last_name) #{ direction }, LOWER(users.first_name) #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  	}

  	def self.options_for_sorted_by
    	[
      		['Name (a-z)', 'name_asc'],
      		['Name (z-a)', 'name_desc'],
      		['Created at (desc)', 'created_at_desc'],
      		['Created at (asc)', 'created_at_asc'],
    	]
  	end

  	def name
    	fullname
  	end

  	scope :search_query, -> (search) { where("LOWER(fullname) LIKE ?", "%#{search.downcase}%") }
end