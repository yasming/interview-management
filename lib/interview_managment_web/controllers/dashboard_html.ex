defmodule InterviewManagmentWeb.DashboardHTML do
  @moduledoc """
  This module contains pages rendered by DashboardController.

  See the `dashboard_html` directory for all templates available.
  """
  use InterviewManagmentWeb, :html

  embed_templates "dashboard_html/*"
end
