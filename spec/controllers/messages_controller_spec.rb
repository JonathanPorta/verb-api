require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe MessagesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Message. As you add validations to Message, be sure to
  # adjust the attributes here as well.

  before :each do
    @sender = FactoryGirl.create :user
    @recipient = FactoryGirl.create :user

    @sent_message = Message.create!(
      sender: @sender,
      recipient: @recipient,
      verb: 'hug'
    )

    @received_message = Message.create!(
      sender: @recipient,
      recipient: @sender,
      verb: 'poke'
    )

    request.session[:user_id] = @sender.id
    # TODO: Make some peoples message each other.
  end

  let(:valid_sender_attributes) { { sender_id: @sender.id, recipient_id: @recipient.id, verb: @sent_message.verb } }
  let(:valid_recipient_attributes) { { sender_id: @recipient.id, recipient_id: @sender.id, verb: @received_message.verb } }

  let(:invalid_attributes) { { id: 'string', recipient_id: -1 } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MessagesController. Be sure to keep this updated too.
  let(:valid_session) { { user_id: @sender.id } }

  describe 'GET sent' do
    it 'assigns sent messages as @messages' do
      message = Message.create! valid_sender_attributes
      get 'sent', {}, valid_session
      expect(assigns(:messages)).to include(message)
    end
  end

  describe 'GET received' do
    it 'assigns received messages as @messages' do
      message = Message.create! valid_recipient_attributes
      get 'received', {}, valid_session
      expect(assigns(:messages)).to include(message)
    end
  end

  describe 'GET show' do
    it 'assigns the requested message as @message' do
      message = Message.create! valid_sender_attributes
      get :show, { id: message.to_param }, valid_session
      expect(assigns(:message)).to eq(message)
    end
  end

  describe 'GET new' do
    it 'assigns a new message as @message' do
      get :new, {}, valid_session
      expect(assigns(:message)).to be_a_new(Message)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested message as @message' do
      message = Message.create! valid_sender_attributes
      get :edit, { id: message.to_param }, valid_session
      expect(assigns(:message)).to eq(message)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Message' do
        expect { post :create, { message: valid_sender_attributes }, valid_session }.to change(Message, :count).by(1)
      end

      it 'assigns a newly created message as @message' do
        post :create, { message: valid_sender_attributes }, valid_session
        expect(assigns(:message)).to be_a(Message)
        expect(assigns(:message)).to be_persisted
      end

      it 'redirects to the created message' do
        post :create, { message: valid_sender_attributes }, valid_session
        expect(response).to redirect_to(Message.last)
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved message as @message' do
        post :create, { message: invalid_attributes }, valid_session
        expect(assigns(:message)).to be_a_new(Message)
      end

      it 're-renders the new template' do
        post :create, { message: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_attributes) { { verb: 'update' } }

      it 'updates the requested message' do
        message = Message.create! valid_sender_attributes
        put :update, { id: message.to_param, message: new_attributes }, valid_session
        message.reload
        expect(message.verb).to eq('update')
      end

      it 'assigns the requested message as @message' do
        message = Message.create! valid_sender_attributes
        put :update, { id: message.to_param, message: valid_sender_attributes }, valid_session
        expect(assigns(:message)).to eq(message)
      end

      it 'redirects to the message' do
        message = Message.create! valid_sender_attributes
        put :update, { id: message.to_param, message: valid_sender_attributes }, valid_session
        expect(response).to redirect_to(message)
      end
    end

    describe 'with invalid params' do
      it 'assigns the message as @message' do
        message = Message.create! valid_sender_attributes
        put :update, { id: message.to_param, message: invalid_attributes }, valid_session
        expect(assigns(:message)).to eq(message)
      end

      it 're-renders the edit template' do
        message = Message.create! valid_sender_attributes
        put :update, { id: message.to_param, message: invalid_attributes }, valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested message' do
      message = Message.create! valid_sender_attributes
      expect { delete :destroy, { id: message.to_param }, valid_session }.to change(Message, :count).by(-1)
    end

    it 'redirects to the messages list' do
      message = Message.create! valid_sender_attributes
      delete :destroy, { id: message.to_param }, valid_session
      expect(response).to redirect_to(messages_url)
    end
  end

end
