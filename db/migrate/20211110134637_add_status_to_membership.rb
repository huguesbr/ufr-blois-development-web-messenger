class AddStatusToMembership < ActiveRecord::Migration[5.2]
  def change
    # https://guides.rubyonrails.org/active_record_migrations.html#column-modifiers
    add_column :memberships, :status, :string, default: 'pending'
  end
end
