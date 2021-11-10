class AddStatusToMembership < ActiveRecord::Migration[5.2]
  def change
    add_column :memberships, :status, :string
  end
end
