module ProfileHelper

  def pronunciation_of_options(user)
    User.pronunciation_ofs.keys
    .map {|k| [@user.public_send(k), k.to_s]}
    .reject {|arr| arr[0].blank?}
    .uniq {|arr| arr[0]}
  end

end
