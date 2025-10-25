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

  def calculate_growth
    latest_model = current_user.hair_models.order(created_at: :desc).first
    
    unless latest_model
      return render json: { error: "計算に必要な模型データがありません。" }, status: :not_found
    end

    current_L = latest_model.current_length.to_f
    target_L  = latest_model.target_length.to_f
    max_L     = latest_model.max_length.to_f
    growth_V  = latest_model.daily_growth_rate.to_f || 0.3

    results = {}

    #理想までの計算過程
    if target_L > current_L && growth_V > 0
      days_to_target = (target_L - current_L) / growth_V
      target_date = Date.current + days_to_target.ceil.days
      results[:days_to_target] = days_to_target.ceil
      results[:target_date] = target_date.strftime("%Y-%m-%d")
    else
      results[:days_to_target] = 0
      results[:message_target] = "目標の長さは現在の長さを超えていません。"
    end

    #理想からの計算過程
    if max_L > current_L && growth_V > 0
      days_to_max = (max_L - current_L) / growth_V
      results[:days_until_overgrown] = days_to_max.ceil
      results[:overgrown_date] = (Date.current + days_to_max.ceil.days).strftime("%Y-%m-%d")
    elsif max_L <= current_L
      # 既に許容限界を超えている場合
      results[:days_overgrown] = ((current_L - max_L) / growth_V).ceil
      results[:message_overgrown] = "許容限界を#{results[:days_overgrown]}日超えています。すぐに散髪が必要です。"
    end

    render json: results, status: :ok
  end

  private

  def hair_model_params
    params.permit(:photo, :model_data)
  end
end
