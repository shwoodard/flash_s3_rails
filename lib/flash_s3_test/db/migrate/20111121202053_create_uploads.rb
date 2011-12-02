class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :upload_s3_key
      t.string :upload_with_block_s3_key

      t.timestamps
    end
  end
end
