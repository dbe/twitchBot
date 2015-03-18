class PointTransaction < ActiveRecord::Base
  belongs_to :from, :class_name => 'Viewer'
  belongs_to :to, :class_name => 'Viewer'

  def self.system_pay(viewer, amount)
    self.facilitate_payment(nil, viewer, amount, true)
  end

  def self.facilitate_payment(from, to, amount, system=false)
    ActiveRecord::Base.transaction do
      if not system
        from.lock!
        from.withdrawl(amount)
      end

      to.lock!
      to.deposit(amount)

      self.create!(:from => from, :to => to, :amount => amount, :time => Time.new)
    end
  end
end
