class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  attachment :profile_image # ここを追加
  validates :name, presence: true, uniqueness: true, length: {minimum: 2, maximum: 20}
  validates :introduction, length: { maximum: 50 }
  validates :postal_code, presence: true
  validates :prefecture_code, presence: true
  validates :city, presence: true
  validates :street, presence: true

  has_many :favorites

  #Relationshipに対して、外部キーのfollower_idを見て、followerって名前でアソシエーションする、あ後、関連するUserインスタンスが消えた時は、followerも消しとくんで
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id",dependent: :destroy #フォロー取得、foreign_keyは関連先モデルの外部キーを指定
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id",dependent: :destroy #フォロワー取得

  #active_relationshipsモデルを経由した上で、followedモデルに対して、following_userって名前でアソシエーションしときますね
  #フォローする人がフォローされる人を結ぶ関係を表す
  has_many :following_user, through: :active_relationships, source: :followed #自分がフォローしている人
  has_many :follower_user, through: :passive_relationships, source: :follower #自分をフォローしている人

  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user_rooms

  def follow(user_id)
    active_relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    active_relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    following_user.include?(user)
  end

  #登録時にメールアドレスを不要とする
  def email_required?
    false
  end

  def email_changed?
    false
  end

  def self.search_for(model,content,method)
      if method == 'perfect'
        User.where(name: content)
      elsif method == 'forward'
        User.where('name LIKE ?', content+'%')
      elsif method == 'backward'
        User.where('name LIKE ?', '%'+content)
      else
        User.where('name LIKE ?', '%'+content+'%')
      end
  end 

  def update_without_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      validate validate! _validators
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

end
