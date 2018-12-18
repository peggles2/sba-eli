class CustomContentsController < ApplicationController
  include PolymorphicResource

  def show
    render json: return_json(contentable)
  end

  def create
    custom_content = CustomContent.new(contentable: resource_model)
    custom_content.content = model_params[:content]
    if custom_content.save
      render json: return_json(custom_content), status: :created
    else
      render errors_for(custom_content)
    end
  end

  def update
    if contentable.update(model_params)
      render json: return_json(contentable), status: :ok
    else
      render errors_for(content)
    end
  end

  private

  def resource_model
    @resource_model ||= resource
  end

  def contentable
    resource_model.custom_content
  end

  def model_params
    params.require(:custom_content).permit(:content)
  end

  def return_json(content)
    { content: content&.content }
  end
end
