defmodule Eyesite.Scheduler do
  use Quantum, otp_app: :eyesite
end

defmodule Eyesite.Scheduler.Jobs.CheckHosts do
  use EyesiteWeb, :controller
  alias Eyesite.Front
  require Logger

  def run do
    Logger.info("Checking minutely hosts")

    Front.list_services()
    |> Enum.each(fn service ->
      {result, description} = Eyesite.Hostchecker.check(service.ip, service.port)

      if result == :ok do
        Logger.info("Host #{service.ip} is up")
      else
        Logger.info("Host #{service.ip} is down #{description}")
      end
      :ok
    end)
  end
end
