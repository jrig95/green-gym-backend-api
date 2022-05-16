class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :admin, :created_at
end
