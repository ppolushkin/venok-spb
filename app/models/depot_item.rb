class DepotItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :depot

  validates_uniqueness_of :product_id, :scope => :depot_id

  def put(count)
    if count < 0
      return false
    end

    self.count+=count
    save
  end

  def hold(count)
    if count < 0
      return false
    end

    if availiable >= count
      self.hold_count+=count;
      save
      return true
    else
      raise ActiveRecord::Rollback
    end
  end

  def unhold(count)
    if count < 0
      return false
    end

    if hold_count>=count
      self.hold_count-=count
      save
      return true
    else
      return false
    end

  end

  def remove_from_holded(holded)
    if holded < 0
      return false
    end

    if self.hold_count >= holded
      self.hold_count-=holded
      self.count-=holded
      save
      return true
    else
      return false
    end
  end

  def remove(count)
    if count < 0
      return false
    end

    if availiable >= count
      self.count-=count
      save
      return true
    else
      return false
    end
  end

  def availiable()
    count - hold_count
  end



end
