defmodule PingSiteWeb.FormTextInput do
  use Phoenix.Component

  def text_input(assigns) do
    ~H"""
      <input type="text" />
    """
  end
end
