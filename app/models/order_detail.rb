class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order
  
  enum status: { cannot_be_started: 0, awaiting_manufacture: 1, under_manufacture: 2, completion_of_manufacturing: 3 }
end
