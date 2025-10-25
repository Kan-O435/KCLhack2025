# app/controllers/api/v1/appointments_controller.rb

class Api::V1::AppointmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @appointments = current_user.appointments.order(appointment_date: :asc)
    render json: @appointments, status: :ok
  end

  def create
    @appointment = current_user.appointments.build(appointment_params)
    if @appointment.save
      render json: @appointment, status: :created
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  private

  def appointment_params
    params.permit(:appointment_date, :salon_name, :salon_id, :status, :notes)
  end
end