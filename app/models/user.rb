class User < ApplicationRecord
  include Kaminari::PageScopeMethods

  enum status: {
    pending: 'pending',
    approved: 'approved',
    rejected: 'rejected'
  }

   paginates_per 5
end
