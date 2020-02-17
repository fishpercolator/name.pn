json.name             t('product_name')
json.short_name       t('product_name')
json.start_url        '/'
json.theme_color      '#3d9970'
json.background_color '#ffffff'
json.display          'standalone'
json.orientation      'portrait'
json.icons do
  json.array! [128, 144, 152, 192, 512] do |s|
    json.src "/logos/logo-#{s}.png"
    json.type 'image/png'
    json.sizes "#{s}x#{s}"
  end
end
