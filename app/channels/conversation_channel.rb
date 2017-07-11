# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ConversationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conversations-#{current_user.id}"
  end

  def unsubscribed
    stop_all_streams
  end

  def speak(data)
    mess_params = data['mess'].each_with_object({}) do |el, hash|
      hash[el.values.first] = el.values.last
    end

    Mess.create(mess_params)
  end
end
