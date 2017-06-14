class CreateIdentities < ActiveRecord::Migration[5.1]
  def change
    create_table :identities do |t|
      t.references :user, null: false
      t.string :uid, null: false
      t.string :provider, null: false
    end
  end
end
