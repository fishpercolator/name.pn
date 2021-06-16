module UserImage
  extend ActiveSupport::Concern
  
  BG_FILE = Rails.root + 'app/assets/images/hello.png'
  FONT    = Rails.root + 'app/assets/fonts/PatrickHand-Regular.ttf'
  
  included do
    
    def profile_image
      ImageProcessing::MiniMagick
        .source(BG_FILE)
        .append('-font', FONT)
        .append('-pointsize', 90)
        .append('-gravity', 'center')
        .append('-draw', %{text 0,85 #{im_quote personal_name}})
        .convert!("png")
    end
    
  end
  
  private
  
  # Quote strings for imagemagick
  def im_quote(str)
    str = str.gsub(/\\/, %q{\\\\\\\\})
    str = str.gsub(/'/, %q{\\\\'})
    %{' #{str} '}
  end

end
