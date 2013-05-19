# encoding: utf-8

class MediumFotoUploader < FotoUploader

  process :resize_to_fit => [300, 400]

end
