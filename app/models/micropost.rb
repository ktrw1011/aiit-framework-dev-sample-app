class Micropost < ApplicationRecord
  belongs_to :user
  # Active Strageとの関連づけ
  has_one_attached :image
  # user_idが存在しているか確認
  validates :user_id, presence: true
  # contentの空文字は許可しない。文字数は140文字が最大
  validates :content, presence: true, length: { maximum: 140 }
  # DBからフェッチする際のデフォルト順
  default_scope -> { order(created_at: :desc) }
  
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "must be a valid image format" },
                      size:         { less_than: 5.megabytes,
                                      message: "should be less than 5MB" }

  # # リサイズ済みの画像を返す
  def display_image
    image.variant(resize_to_limit: [500, 500])
  end
end
