json.extract! user, :id, :full_name, :last_name, :first_name, :last_name_kana, :first_name_kana, :email, :birthday, :sex, :administrator, :disable, :prefecture_id, :tenant_id
json.image user.encoded_image
