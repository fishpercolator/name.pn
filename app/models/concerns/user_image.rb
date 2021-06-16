module UserImage
  extend ActiveSupport::Concern
  
  BG_FILE = Rails.root + 'app/assets/images/hello.png'
  FONT    = Rails.root + 'app/assets/fonts/PatrickHand-Regular.ttf'
  
  included do
    
    def profile_image
      ImageProcessing::MiniMagick
        .source(BG_FILE)
        .append('-font', FONT)
        .append('-pointsize', 100)
        .append('-gravity', 'center')
        .append('-draw', 'text 0,80 Quinn')
        .convert!("png")
    end
    
  end
end
