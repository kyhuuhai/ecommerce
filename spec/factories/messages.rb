FactoryGirl.define do
  factory :message do
    body "content"
    user_id 1
    chat_room_id 1
  end
end
