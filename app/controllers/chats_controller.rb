class ChatsController < ApplicationController
	def show
		@user=User.find(params[:id])
		rooms = current_user.user_rooms.pluck(:room_id)  ##current_user.user_roomsモデルのroom_idカラムの中身を全て取ってくる
		user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)  ##user_idが「@user.id」でなおかつ,room_idが「rooms」の最初のレコードを取得

		unless user_rooms.nil?  ##user_roomsが存在しないことはない＝＝user_roomsが存在する場合
      		@room = user_rooms.room
      	else
      		@room = Room.new
      		@room.save
      		UserRoom.create(user_id: current_user.id, room_id: @room.id)
      		UserRoom.create(user_id: @user.id, room_id: @room.id)
      	end
      	@chats = @room.chats
      	
      	@chat = Chat.new(room_id: @room.id)  ##値を設定してモデルオブジェクト生成できる
	end
	def create
		@chat=Chat.new(chat_params)
		@chat.user_id=current_user.id
		@chat.save
	end
	private
	def chat_params
		params.require(:chat).permit(:message,:room_id)
	end
end
