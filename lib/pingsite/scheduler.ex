defmodule PingSite.Scheduler do
  use Quantum, otp_app: :pingsite
end

defmodule PingSite.Scheduler.Jobs.CheckHosts do
  use PingSiteWeb, :controller
  alias PingSite.Services
  alias PingSite.Users
  require Logger

  def run do
    Services.list_services()
    |> Enum.each(fn service ->
      {result, description} = PingSite.Hostchecker.check(service.host, service.port)

      if result == :ok do
        Logger.info("Host #{service.host} is up")
      else
        Logger.info("Host #{service.host} is down #{description}")

        PingSiteWeb.Endpoint.broadcast("updates:errors", "say", %{
          "hostid" => service.id,
          "message" => "Host #{service.host} is down #{description}"
        })

        Logger.info("Sending push notifications")

        Users.get_registrations(service.user_id)
        |> Enum.each(fn registration ->
          IO.inspect(registration)

          n =
            Pigeon.FCM.Notification.new({:token, registration.registration_id}, %{
              "body" => "test message"
            })

          PingSite.FCM.push(n)
          nil
        end)
      end

      :ok
    end)
  end
end
