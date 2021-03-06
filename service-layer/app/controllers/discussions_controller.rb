class DiscussionsController < ApplicationController
  before_action :valid_session?, only: :create

  def index
    discussion_map = DiscussionMap.find_by(
      content_type: params[:content_type],
      content_id: params[:content_id],
    )

    @discussion_replies = if discussion_map.present?
                            response = DiscourseClient.create.topic_posts(
                              discussion_map.discussion_id,
                            )
                            @post_count = response["post_stream"]["posts"].size
                            # remove the count for the initial system generated post
                            @post_count = @post_count.positive? ? @post_count - 1 : 0
                            DiscussionReply.from_discourse_list(response)
                          else
                            @post_count = 0
                            []
                          end
  end

  def create
    discussion_map = DiscussionMap.find_by(
      content_type: params[:content_type],
      content_id: params[:content_id],
    )

    @discussion_reply = if discussion_map
                          DiscussionReply.new(
                            model_params.merge!(
                              user: Current.user,
                              discussion_id: discussion_map.discussion_id,
                            ),
                          )
                        else
                          Discussion.new(
                            model_params.merge!(
                              content_type: params[:content_type],
                              content_id: params[:content_id],
                              user: Current.user,
                            ),
                          )
                        end

    if @discussion_reply.create
      render status: :created
    else
      render errors_for(@discussion_reply)
    end
  end

  private

  def model_params
    params.require(:discussion_reply).permit(
      :discussion_id,
      :raw,
      :reply_to_post_number,
    )
  end
end
