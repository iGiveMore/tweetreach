Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'H5moFHvICy2fDAnv5Gg', '7P1BI4Bpl0r1FUYYZxGd5uW78TigeZ2fr4ttveLpA'
   if Rails.env.development?
      OmniAuth.config.full_host = "http://localhost:3000/auth/twitter"
   end
   
end