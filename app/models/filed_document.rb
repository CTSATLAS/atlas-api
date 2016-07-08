class FiledDocument < ApplicationRecord
  belongs_to :admin_id, class_name: 'User', foreign_key: 'admin_id'
  belongs_to :cat_1, class_name: 'DocumentFilingCategory', foreign_key: 'cat_1'
  belongs_to :cat_2, class_name: 'DocumentFilingCategory', foreign_key: 'cat_2'
  belongs_to :cat_3, class_name: 'DocumentFilingCategory', foreign_key: 'cat_3'
  belongs_to :user_id, class_name: 'User', foreign_key: 'user_id'
end
