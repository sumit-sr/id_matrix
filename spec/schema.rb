ActiveRecord::Schema.define do
self.verbose = false

  create_table :veda_idmatrix_requests do |t|
    t.text :xml
    t.text :soap
    t.text :access
    t.text :entity
    t.text :struct
    t.timestamps
  end

  create_table :veda_idmatrix_responses  do |t|
    t.text :headers
    t.integer :code
    t.text :xml
    t.text :struct
    t.boolean :success
    t.integer :request_id
    t.timestamps
  end
end
