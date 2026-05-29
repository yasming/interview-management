defmodule InterviewManagmentWeb.InterviewHTML do
  @moduledoc """
  This module contains pages rendered by InterviewController.

  See the `interview_html` directory for all templates available.
  """
  use InterviewManagmentWeb, :html

  import InterviewManagmentWeb.InterviewAddModal

  embed_templates "interview_html/*"
end
