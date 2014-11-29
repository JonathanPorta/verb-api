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

RSpec.describe AuthProvidersController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # AuthProvider. As you add validations to AuthProvider, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { skip('Add a hash of attributes valid for your model') }

  let(:invalid_attributes) { skip('Add a hash of attributes invalid for your model') }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AuthProvidersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET index' do
    it 'assigns all auth_providers as @auth_providers' do
      auth_provider = AuthProvider.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:auth_providers)).to eq([auth_provider])
    end
  end

  describe 'GET show' do
    it 'assigns the requested auth_provider as @auth_provider' do
      auth_provider = AuthProvider.create! valid_attributes
      get :show, { id: auth_provider.to_param }, valid_session
      expect(assigns(:auth_provider)).to eq(auth_provider)
    end
  end

  describe 'GET new' do
    it 'assigns a new auth_provider as @auth_provider' do
      get :new, {}, valid_session
      expect(assigns(:auth_provider)).to be_a_new(AuthProvider)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested auth_provider as @auth_provider' do
      auth_provider = AuthProvider.create! valid_attributes
      get :edit, { id: auth_provider.to_param }, valid_session
      expect(assigns(:auth_provider)).to eq(auth_provider)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new AuthProvider' do
        expect { post :create, { auth_provider: valid_attributes }, valid_session }.to change(AuthProvider, :count).by(1)
      end

      it 'assigns a newly created auth_provider as @auth_provider' do
        post :create, { auth_provider: valid_attributes }, valid_session
        expect(assigns(:auth_provider)).to be_a(AuthProvider)
        expect(assigns(:auth_provider)).to be_persisted
      end

      it 'redirects to the created auth_provider' do
        post :create, { auth_provider: valid_attributes }, valid_session
        expect(response).to redirect_to(AuthProvider.last)
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved auth_provider as @auth_provider' do
        post :create, { auth_provider: invalid_attributes }, valid_session
        expect(assigns(:auth_provider)).to be_a_new(AuthProvider)
      end

      it 're-renders the new template' do
        post :create, { auth_provider: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_attributes) { skip('Add a hash of attributes valid for your model') }
      it 'updates the requested auth_provider' do
        auth_provider = AuthProvider.create! valid_attributes
        put :update, { id: auth_provider.to_param, auth_provider: new_attributes }, valid_session
        auth_provider.reload
        skip('Add assertions for updated state')
      end

      it 'assigns the requested auth_provider as @auth_provider' do
        auth_provider = AuthProvider.create! valid_attributes
        put :update, { id: auth_provider.to_param, auth_provider: valid_attributes }, valid_session
        expect(assigns(:auth_provider)).to eq(auth_provider)
      end

      it 'redirects to the auth_provider' do
        auth_provider = AuthProvider.create! valid_attributes
        put :update, { id: auth_provider.to_param, auth_provider: valid_attributes }, valid_session
        expect(response).to redirect_to(auth_provider)
      end
    end

    describe 'with invalid params' do
      it 'assigns the auth_provider as @auth_provider' do
        auth_provider = AuthProvider.create! valid_attributes
        put :update, { id: auth_provider.to_param, auth_provider: invalid_attributes }, valid_session
        expect(assigns(:auth_provider)).to eq(auth_provider)
      end

      it 're-renders the edit template' do
        auth_provider = AuthProvider.create! valid_attributes
        put :update, { id: auth_provider.to_param, auth_provider: invalid_attributes }, valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested auth_provider' do
      auth_provider = AuthProvider.create! valid_attributes
      expect { delete :destroy, { id: auth_provider.to_param }, valid_session }.to change(AuthProvider, :count).by(-1)
    end

    it 'redirects to the auth_providers list' do
      auth_provider = AuthProvider.create! valid_attributes
      delete :destroy, { id: auth_provider.to_param }, valid_session
      expect(response).to redirect_to(auth_providers_url)
    end
  end

end
