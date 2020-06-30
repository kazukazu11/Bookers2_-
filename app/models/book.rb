class Book < ApplicationRecord
	belongs_to :user
	validates :title, presence: true
    validates :body, presence: true
    validates :body, length: { maximum: 200 }
    has_many :book_comments
    has_many :favorites

    def favorited_by?(user)
    	favorites.where(user_id: user.id).exists?
    end

    def self.search_for(model,content,method)
    	if method == 'perfect'
			Book.where(title: content)
		elsif method == 'forward'
			Book.where('title LIKE ?', content+'%')
		elsif method == 'backward'
			Book.where('title LIKE ?', '%'+content)
		else
			Book.where('title LIKE ?', '%'+content+'%')
		end
    end
end