require 'rails_helper'

RSpec.describe DevicesController, type: :controller do
  before :each do
    @user = FactoryGirl.create :user
    request.session[:user_id] = @user.id
    request.accept = 'application/json'
  end

  let(:valid_attributes) { { token: '{SAMPLETOKEN}' } }
  let(:invalid_attributes) { { token: nil } }
  let(:valid_session) { { user_id: @user.id } }

  describe 'POST create.json' do
    describe 'with valid params' do
      it 'creates a new Device' do
        expect { post :create, { device: valid_attributes }, format: :json }.to change(Device, :count).by(1)
      end

      it 'assigns a newly created device as @device' do
        post :create, { device: valid_attributes }, valid_session
        expect(assigns(:device)).to be_a(Device)
        expect(assigns(:device)).to be_persisted
      end
    end
  end
end
