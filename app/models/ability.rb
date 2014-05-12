class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif  user.moderator?
      can :manage, :all
      cannot :update, Profile, :locked => true
      cannot :manage, User
      cannot :delete, Profile
      cannot :destroy, Profile
      cannot [:unlock, :lock], Profile
    else
      can :read, :all
      cannot :manage, User
    end
  end
end
