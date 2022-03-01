defmodule PingSite.Scheduler do
  use Quantum, otp_app: :pingsite
end

defmodule PingSite.Scheduler.Jobs.CheckHosts do
  use PingSiteWeb, :controller
  alias PingSite.Services
  require Logger

  def run do
    Logger.info("Checking minutely hosts")

    Services.list_services()
    |> Enum.each(fn service ->
      {result, description} = PingSite.Hostchecker.check(service.host, service.port)

      if result == :ok do
        Logger.info("Host #{service.host} is up")
      else
        Logger.info("Host #{service.host} is down #{description}")
      end
      :ok
    end)
  end
end
