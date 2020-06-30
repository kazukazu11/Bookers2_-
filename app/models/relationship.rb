class Relationship < ApplicationRecord
	belongs_to :follower, class_name: "User" #Userモデルに対して、followerって名前で関連付けしときますね
	belongs_to :followed, class_name: "User"
end