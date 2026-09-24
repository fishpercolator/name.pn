class Components::Profile::LikenessUploader < Components::Base
  include Phlex::Rails::Helpers::ImageTag

  def initialize(form)
    @form = form
  end

  def view_template
    div(class: 'likeness_uploader flex items-start justify-between gap-4', data: { controller: 'likeness-uploader' }) do
      div(class: 'flex flex-col gap-2') do
        Button(variant: :success, size: :lg, icon: 'file-upload-outline', data: { action: 'likeness-uploader#start' }) { t('.upload') }
        @form.submit(t('.delete'), name: 'button', value: 'delete_likeness', variant: :danger, size: :lg, icon: 'delete', disabled: !likeness.attached?, data: { likeness_uploader_target: 'delete' })
      end
      div(class: '[&_img]:rounded-full', data: { likeness_uploader_target: 'preview' }) { preview if likeness.attached? }
    end
  end

  private

  def likeness = @form.object.likeness

  def preview
    image_tag(likeness.variant(resize_to_limit: [300, 300]), alt: t('components.ui.likeness.alt', name: @form.object.full_name))
  end
end
