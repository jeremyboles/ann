require Protocol

Protocol.derive(Jason.Encoder, Ecto.Changeset, only: [:action, :changes])
