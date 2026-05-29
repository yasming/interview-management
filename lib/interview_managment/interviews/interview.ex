defmodule InterviewManagment.Interviews.Interview do
  use Ecto.Schema
  import Ecto.Changeset

  schema "interviews" do
    field :date_applied, :date
    field :date_contacted, :date
    field :description, :string
    field :link, :string
    field :company_name, :string
    field :got_interview, :boolean

    timestamps(type: :utc_datetime)
  end

  def changeset(interview, attrs) do
    interview
    |> cast(attrs, [
      :date_applied,
      :date_contacted,
      :description,
      :link,
      :company_name,
      :got_interview
    ])
    |> validate_required([:date_applied, :description, :link, :company_name])
  end
end
