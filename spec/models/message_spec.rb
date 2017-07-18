require 'rails_helper'

RSpec.describe Message, type: :model do
  context "associations" do
    it{is_expected.to belong_to :user}
    it{is_expected.to belong_to :chat_room}
  end

  context "validations" do
    it{is_expected.to validate_presence_of :body}
    it{is_expected.to validate_length_of(:body).is_at_least(2).is_at_most(1000)}
  end

  describe "get created at time" do
    let!(:message){FactoryGirl.create :message, created_at: Time.now}
    it "return created_at with format" do
      expect(message.timestamp).to eq message.created_at.strftime('%H:%M:%S %d %B %Y')
    end
  end
end
