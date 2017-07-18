require "rails_helper"

RSpec.describe ChatRoomsController, type: :controller do

  let!(:user){FactoryGirl.create :user}
  let!(:chat_room){FactoryGirl.create :chat_room}

  before :each do
    allow(controller).to receive(:current_user).and_return user
  end

  describe "GET #index" do
    before{get :index}

    context "render the index page" do
      it{expect(subject).to respond_with 200}
      it{expect(subject).to render_template :index}
    end

    context "get all chat rooms" do
      it{expect(assigns(:chat_rooms)).to eq [chat_room]}
    end
  end

  describe "GET #new" do
    before{get :new}
    context "render the new page" do
      it{expect(subject).to respond_with 200}
      it{expect(subject).to render_template :new}
    end

    context "get new chat room" do
      it{expect(assigns(:chat_room)).to be_a_new ChatRoom}
    end
  end

  describe "GET #show" do
    it do
      get :show, params: {id: chat_room.id}
      expect(assigns(:chat_room)).to eq chat_room
      expect(assigns(:message)).to be_a_new Message
    end
  end

  describe "POST #create" do
    it "create chat room successfully" do
      expect do
        get :create, params: {chat_room: {title: "New Chat Rooom"}}
      end.to change(ChatRoom, :count).by 1

      expect(subject).to redirect_to chat_rooms_path
    end
  end
end