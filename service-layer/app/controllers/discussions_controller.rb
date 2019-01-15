class DiscussionsController < ApplicationController
  def show
    discussion_map = DiscussionMap.find_by(
      content_type: params[:content_type],
      content_id: params[:content_id],
    )

    unless discussion_map
      client = DiscourseClient.create
      response = client.create_topic(
        skip_validations: true,
        title: "Discussion #{params[:content_type]} #{params[:content_id]}",
        raw: "Please discuss this here!",
      )

      discussion_map = DiscussionMap.create!(
        content_type: params[:content_type],
        content_id: params[:content_id],
        discussion_id: response["topic_slug"],
      )
    end

    replies = DiscourseClient.create.topic(discussion_map.discussion_id)
    render json: replies
  end

  def create
    render json: null
  end
end
