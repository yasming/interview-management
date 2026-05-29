defmodule InterviewManagmentWeb.InterviewAddModal do
  @moduledoc """
  The modal dialog used to add a new interview.
  """
  use InterviewManagmentWeb, :html

  @doc """
  Renders the modal dialog used to add a new interview.
  """
  attr :form, Phoenix.HTML.Form, required: true

  def interview_modal(assigns) do
    ~H"""
    <dialog id="interview_modal" class="modal">
      <div class="modal-box">
        <h3 class="text-lg font-semibold mb-4">Add interview</h3>
        <.form for={@form} action={~p"/interviews"} method="post" class="space-y-4">
          <.input
            field={@form[:date_applied]}
            type="date"
            label="Date applied"
            value={@form[:date_applied].value || Date.utc_today()}
          />
          <.input field={@form[:description]} type="text" label="Description" />
          <.input field={@form[:link]} type="url" label="Link" />
          <.input field={@form[:company_name]} type="text" label="Company name" />
          <div class="modal-action">
            <button type="button" class="btn" onclick="interview_modal.close()">Cancel</button>
            <.button variant="primary" type="submit">Save</.button>
          </div>
        </.form>
      </div>
      <form method="dialog" class="modal-backdrop">
        <button>close</button>
      </form>
    </dialog>
    """
  end
end
