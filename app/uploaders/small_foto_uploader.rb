# encoding: utf-8

class SmallFotoUploader < FotoUploader

  process :resize_to_fit => [233, 311]

end
