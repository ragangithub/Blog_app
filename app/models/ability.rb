class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    return unless user.role == 'admin'

    can :manage, :all
  end
end
