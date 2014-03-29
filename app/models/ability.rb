class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif  user.moderator?
      can :manage, :all
      cannot :manage, User
      cannot :delete, Profile
      cannot :destroy, Profile
    else
      can :read, :all
      cannot :read, User
    end
  end
end
