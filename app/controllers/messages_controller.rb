class MessagesController < ApplicationController
	layout "shoutout"
	before_action :require_user
	before_action :find_message, only: [:show, :edit, :update, :destroy]


	def index
		@message = Message.all.order("created_at DESC")
	end

	def new
		@message = current_user.messages.build
	end

	def show
	end

	def create
		@message = current_user.messages.build(message_params)
		if @message.save
			redirect_to '/messages'
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @message.update(message_params)
			redirect_to message_path
		else
			render 'edit'
		end
	end

	def destroy
		@message.destroy
		redirect_to '/messages'
	end


	private

	def message_params
		params.require(:message).permit(:title, :description)
	end

	def find_message
			@message = Message.find(params[:id])
	end
end
