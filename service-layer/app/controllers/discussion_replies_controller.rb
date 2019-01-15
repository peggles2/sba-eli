class DiscussionRepliesController < ApplicationController
  before_action :valid_session?, except: :index

  def index
    response = DiscourseClient.create.topic_posts(params[:discussion_id])
    render json: response
  end

  def show
    response = DiscourseClient.create.get_post(params[:id])
    render json: response
  end

  def create
    reply = DiscussionReply.new(model_params.merge!(user: Current.user))
    reply.discussion_id = params[:discussion_id]
    if reply.create
      render json: reply.response, status: :created
    else
      render errors_for(reply)
    end
  end

  private

  def model_params
    params.require(:discussion_reply).permit(:discussion_id, :raw)
  end
end
