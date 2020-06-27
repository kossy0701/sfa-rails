class Ip < ApplicationRecord
  belongs_to :tenant

  def content
    IPAddress::IPv4.new super
  end

  def content=(value)
    if value.is_a?(IPAddress::IPv4)
      super value.to_string
    else
      super
    end
  end

  def setted_at
    created_at.localtime.to_date.strftime('%Y/%m/%d')
  end
end
