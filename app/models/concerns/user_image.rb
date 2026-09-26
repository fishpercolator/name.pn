module UserImage
  extend ActiveSupport::Concern
  
  BG_FILE = Rails.root + 'app/assets/images/hello.png'
  FONT    = Rails.root + 'app/assets/fonts/PatrickHand-Regular.ttf'

  ANNOTATE_ESCAPES = { '\\' => '\\\\', '%' => '%%', '@' => '\\@' }.freeze
  
  included do
    
    def profile_image
      ImageProcessing::MiniMagick
        .source(BG_FILE)
        .append('-font', FONT)
        .append('-pointsize', 90)
        .append('-gravity', 'center')
        .append('-annotate', '+0+85', im_escape(personal_name))
        .convert!("png")
    end
    
  end
  
  private
  
  def im_escape(str)
    str.gsub(/[\\%@]/, ANNOTATE_ESCAPES)
  end

end
