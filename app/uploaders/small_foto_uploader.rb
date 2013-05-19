# encoding: utf-8

class SmallFotoUploader < FotoUploader

  process :resize_to_fit => [135, 180]

end
