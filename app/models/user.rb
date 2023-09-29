class User < ApplicationRecord


  enum status: {
    pending: 'pending',
    approved: 'approved',
    rejected: 'rejected'
  }

end
