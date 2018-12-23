class SearchesController < ApplicationController
  def show
    @results = Queries::ContentSearch.call(query_parameters)
  end

  private

  # The query param method ensurs that only the following parameters are passed
  # to the ContentSearch method
  def query_parameters
    params.permit(
      :keywords,
      :page,
      :per_page,
      :durations,
      :subjects,
      :media_types,
    )
  end
end
