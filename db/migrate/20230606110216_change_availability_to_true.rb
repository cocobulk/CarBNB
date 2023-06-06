class ChangeAvailabilityToTrue < ActiveRecord::Migration[7.0]
  def change
    change_column_default :cars, :availability, from: nil, to: true
  end
end
