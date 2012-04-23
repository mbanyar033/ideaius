class Topic < ActiveRecord::Base
  belongs_to :user

  # In theory, we shouldn't have to block on this function, even though we do.
  def add_message msg
    @key = "#{self.user}:#{self}"

    if msg.nil?
      return false
    end

    Padrino.cache.sadd @key, msg.id

    return true
  end

  # Gets most resent messages
  def messages count = 50
    @key = "#{self.user}:#{self}"

    Padrino.cache.multi do
      max = Padrino.cache.scard @key
      max = 0 if max.nil?
      min = [0, max-count].max
      p max
      p min

      if min != max
        ids = Padrino.cache.lrange(@key, min, max)
      end
    end

    ids = [] if ids.nil?

    p ids

    return Message.where(:id => ids)
  end

  def to_s
    return self.name
  end
end
