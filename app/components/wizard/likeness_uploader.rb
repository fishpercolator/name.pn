class Components::Wizard::LikenessUploader < Components::Base
  include Phlex::Rails::Helpers::ImageTag

  def initialize(user)
    @user = user
  end

  def view_template
    div(class: 'likeness_uploader flex items-start justify-between gap-4', data: { controller: 'likeness-uploader' }) do
      div(class: 'flex flex-col gap-2') do
        Button(variant: :success, size: :lg, icon: 'file-upload-outline', data: { action: 'likeness-uploader#start' }) { t('.upload') }
        Button(type: :submit, name: 'button', value: 'delete_likeness', variant: :danger, size: :lg, icon: 'delete', disabled: !likeness.attached?, data: { likeness_uploader_target: 'delete' }) { t('.delete') }
      end
      div(class: '[&_img]:rounded-full', data: { likeness_uploader_target: 'preview' }) { preview if likeness.attached? }
    end
  end

  private

  def likeness = @user.likeness

  def preview
    image_tag(likeness.variant(resize_to_limit: [300, 300]), alt: t('components.ui.likeness.alt', name: @user.full_name))
  end
end
