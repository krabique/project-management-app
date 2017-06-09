# automatically generated with rake db:seed:dump
# 09.06.2017 18:56 local time

# FIXED WITH SOME EFFORT MANUALLY AT 21:00


Project.create!([
  {id: 1, title: "My Awesome Project", description: "This is an absolutely awesome project of mine."},
  {id: 2, title: "Gorgeous Project of mine", description: "Just fabulous one, I mean it.  BANANA"},
  {id: 3, title: "A Suckful Project", description: "A really horrible one. Don't even bother... Noone even wants to manage or develop it..."},
  {id: 4, title: "Optimizing The World", description: "A grand plan of coming to powa!"}
])

User.create!([
  {id: 3, email: "severus.snape@hogwarts.co.uk", password: "always", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 23, current_sign_in_at: "2017-06-09 13:34:39", last_sign_in_at: "2017-06-04 19:03:10", current_sign_in_ip: "93.170.143.241", last_sign_in_ip: "46.53.177.123", superadmin_role: true, manager_role: true, user_role: true, name: "Severus Snape", avatar_file_name: "SeverusSnape_WB_F5_SeverusSnapeFullbody_Promo_080615_Port.jpg", avatar_content_type: "image/jpeg", avatar_file_size: 96948, avatar_updated_at: "2017-06-02 14:12:01"},
  {id: 4, email: "minerva.mcgonagall@hogwarts.co.uk", password: "discipline", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 24, current_sign_in_at: "2017-06-09 14:06:14", last_sign_in_at: "2017-06-09 11:54:31", current_sign_in_ip: "93.170.143.241", last_sign_in_ip: "93.170.143.241", superadmin_role: false, manager_role: true, user_role: true, name: "Minerva McGonagall", avatar_file_name: "790333_1328964217692_333_333.jpg", avatar_content_type: "image/jpeg", avatar_file_size: 18171, avatar_updated_at: "2017-06-02 15:06:43"},
  {id: 5, email: "hp@cutie.com", password: "ilived", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 6, current_sign_in_at: "2017-06-09 15:48:08", last_sign_in_at: "2017-06-08 09:18:05", current_sign_in_ip: "46.53.177.123", last_sign_in_ip: "46.216.181.42", superadmin_role: false, manager_role: false, user_role: true, name: "Harry Potter", avatar_file_name: "Potter.jpg", avatar_content_type: "image/jpeg", avatar_file_size: 76605, avatar_updated_at: "2017-06-03 16:13:49"},
  {id: 6, email: "giant.squid@hogwarts.co.uk", password: "tentacles", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 3, current_sign_in_at: "2017-06-07 16:05:52", last_sign_in_at: "2017-06-04 13:23:48", current_sign_in_ip: "46.53.177.123", last_sign_in_ip: "46.53.177.123", superadmin_role: false, manager_role: false, user_role: true, name: "Giant Squid", avatar_file_name: "8abc3e1f3601cdbb0339327e8075396f.jpg", avatar_content_type: "image/jpeg", avatar_file_size: 17321, avatar_updated_at: "2017-06-03 16:15:05"},
  {id: 7, email: "luna.lovegood@hogwarts.co.uk", password: "nargles", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 7, current_sign_in_at: "2017-06-05 19:32:04", last_sign_in_at: "2017-06-04 18:45:42", current_sign_in_ip: "46.53.177.123", last_sign_in_ip: "46.53.177.123", superadmin_role: false, manager_role: false, user_role: true, name: "Luna Lovegood", avatar_file_name: "luna_lovegood_radish_earrings.jpg", avatar_content_type: "image/jpeg", avatar_file_size: 55097, avatar_updated_at: "2017-06-03 16:18:24"},
  {id: 8, email: "anon@anon.com", password: "ligivon", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2017-06-03 17:07:50", last_sign_in_at: "2017-06-03 17:07:50", current_sign_in_ip: "46.53.177.123", last_sign_in_ip: "46.53.177.123", superadmin_role: false, manager_role: false, user_role: true, name: "Too Scared To Come Out", avatar_file_name: nil, avatar_content_type: nil, avatar_file_size: nil, avatar_updated_at: nil},
  {id: 9, email: "lucius.malfoy@darklord.com", password: "purity", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 3, current_sign_in_at: "2017-06-09 14:10:07", last_sign_in_at: "2017-06-05 19:48:03", current_sign_in_ip: "93.170.143.241", last_sign_in_ip: "46.53.177.123", superadmin_role: false, manager_role: false, user_role: true, name: "Lucius Malfoy", avatar_file_name: "457dba61fb8e0392631b486ec0fe607c.jpg", avatar_content_type: "image/jpeg", avatar_file_size: 105994, avatar_updated_at: "2017-06-04 19:01:26"}
])

Document.create!([
  {project_id: 1, cloudinary_uri: "v1496614703/rilrdshftwjiwnqsj1s8.jpg", title: "A great title! abc", creator: 5, last_editor: 9},
  {project_id: 1, cloudinary_uri: "v1496615226/mqo3tmxzas77ylholrxg.jpg", title: "trahanie", creator: 0, last_editor: 3},
  {project_id: 1, cloudinary_uri: "v1496616687/yiztksxqcli7891fuz5w.jpg", title: "stackoverflow lolz", creator: 0, last_editor: 5},
  {project_id: 2, cloudinary_uri: "v1496617049/tywc96tzdbtzcdjzz0qe.jpg", title: "UnknownTitle", creator: 0, last_editor: nil},
  {project_id: 1, cloudinary_uri: "v1497011423/lm7mvbwlwwxxbcjl0brb.jpg", title: "vital loh", creator: 0, last_editor: 4},
  {project_id: 1, cloudinary_uri: "v1497017570/nt3ihr2ezudvlslgxhzx.jpg", title: "UnknownTitle", creator: 0, last_editor: nil},
  {project_id: 1, cloudinary_uri: "v1497017948/z4ljgv5wp2skg2owpou7.jpg", title: "fuck u", creator: 0, last_editor: 9},
  {project_id: 1, cloudinary_uri: "v1497018226/hn3bgv1bdx7nezfr6ilu.jpg", title: "UnknownTitle", creator: 9, last_editor: nil}
])

Project.find_by_id(1).update("user_ids"=>["5", "9"])
Project.find_by_id(2).update("user_ids"=>["4", "5"])
Project.find_by_id(4).update("user_ids"=>["5", "6", "9"])
