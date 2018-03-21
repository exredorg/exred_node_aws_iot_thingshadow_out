defmodule Exred.Node.AwsIotThingShadowOut do
  @moduledoc """
  Publishes messages to AWS IoT Cloud.
  
  The incoming message needs to have a valid AWS topic in the topic field.
  
  Incoming msg format:
  
  ```elixir
  msg = %{
    topic   :: [binary] | binary
    payload :: map,
    qos     :: integer,      # quality of service
    retain  :: boolean       # [GenMQTT doc](https://hexdocs.pm/gen_mqtt/GenMQTT.html#publish/5)
  }
  ```
  """

  @config %{
    thing_name: %{type: "string", value: "myThing"}
  }
  @ui_attributes %{fire_button: false, right_icon: "send" }
  
  @impl true
  def handle_msg(msg, state) do
    encoded_payload = Poison.encode! msg.payload
    res = AwsIotClient.publish msg.topic, encoded_payload, Map.get(msg, :qos, nil), Map.get(msg, :retain, nil)
    { {msg | payload: res}, state }
  end

end
