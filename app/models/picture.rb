class Picture < ApplicationRecord
  belongs_to :imageable, polymorphic: :true

  mount_uploader :name, ImageUploader,
    reject_if: proc{ |param| param[:name].blank? && param[:name_cache].blank? &&
    param[:id].blank? }, allow_destroy: true
end
