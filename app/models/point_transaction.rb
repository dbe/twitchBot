class PointTransaction < ActiveRecord::Base
  belongs_to :from, :class_name => 'Viewer'
  belongs_to :to, :class_name => 'Viewer'
  belongs_to :stream

  def self.system_pay(viewer, amount, stream)
    self.facilitate_payment(nil, viewer, amount, stream)
  end

  def self.facilitate_payment(from, to, amount, stream=nil)
    ActiveRecord::Base.transaction do
      if not stream
        from.lock!
        from.withdrawl(amount)
      end

      to.lock!
      to.deposit(amount)

      self.create!(:from => from, :to => to, :amount => amount, :time => Time.new, :stream => stream)
    end
  end
end
