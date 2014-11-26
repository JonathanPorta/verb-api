class DevicesController < ApplicationController
  # POST /devices.json
  def create
    @device = Device.where(token: device_params[:token]).first_or_initialize.tap do |device|
      device.token = device_params[:token]
      device.user = current_user

      device.save!
    end
  end
end

private

# Never trust parameters from the scary internet, only allow the white list through.
def device_params
  params.require(:device).permit(:token)
end
