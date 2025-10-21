# frozen_string_literal: true

class Api::V1::HairModelsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :index]

  def index
    @models = current_user.hair_models.with_attached_photo
    render json: @models.map { |m| 
      { 
        id: m.id, 
        photo_url: m.photo.attached? ? url_for(m.photo) : nil,
        model_data: m.model_data 
      }
    }
  end

  def create
    @model = current_user.hair_models.build(hair_model_params)
    
    if @model.save
      render json: { 
        id: @model.id, 
        photo_url: url_for(@model.photo), 
        message: "写真と模型データを保存" 
      }, status: :created
    else
      render json: @model.errors, status: :unprocessable_entity
    end
  end

  private

  def hair_model_params
    params.permit(:photo, :model_data)
  end
end
