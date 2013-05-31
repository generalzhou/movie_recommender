def get_random_image 
  full_path = Dir[APP_ROOT.join('public', 'imgs', '*.jpg')].sample
  '/' + full_path.split('/')[-2..-1].join('/')
end
