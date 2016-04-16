class Api::V1::SessionSerializer < Api::V1::BaseSerializer
  #just some basic attributes
  attributes :id, :email, :first_name, :token

  def token
    object.remember_token
  end
end
