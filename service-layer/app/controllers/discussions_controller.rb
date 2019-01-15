require 'discourse_api'
class DiscussionsController < ApplicationController
    #include DiscourseAPI
    def show
      client = DiscourseApi::Client.new("https://forum-dev.eli.fearless.tech")
      @results = DiscussionMap.where(query_parameters)
    end

    def create
      render json: null
    end

    # The query param method ensures that only the following parameters are passed
    # to the method
    def query_parameters
      params.permit(
        :content_id,
        :content_type,
        :page
      )
    end
  end
