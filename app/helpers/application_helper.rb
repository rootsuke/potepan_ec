module ApplicationHelper
  # ページごとの完全なタイトルを返します。
  def full_title(page_title = "")
    base_title = "BIGBAG Store"
    return base_title if page_title.empty?

    "#{page_title} | #{base_title}"
  end
end
