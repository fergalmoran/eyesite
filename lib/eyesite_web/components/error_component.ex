defmodule EyesiteWeb.Components.ErrorComponent do
  use Phoenix.Component

  def error(assigns, changeset) do
    ~H"""
    <span>
      <h1>Errors</h1>
      <%= IO.inspect(changeset) %>
    </span>
    """
  end

  def href(assigns) do
    ~H"""
      <a
        href={@href}
        class={"#{@bg_color} #{@text_color} hover:brightness-150 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm w-full sm:w-auto px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800 inline-flex items-center"}
      >
          <Heroicons.LiveView.icon name={@icon}
            type="outline" class="w-4 h-4 mr-2" />
          <span><%= @text %></span>
      </a>
    """
  end
end
