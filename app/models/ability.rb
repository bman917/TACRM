class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
      can :restore, Profile
    elsif  user.moderator?
      can :manage, :all
      cannot :update, Profile, :locked => true
      cannot :manage, User
      cannot :delete, Profile
      cannot :destroy, Profile
      cannot :destroy, Transaction
      cannot [:unlock, :lock], Profile
    else
      can :read, :all
      can :json, Profile
      can :expiring, Identification
      cannot :manage, User
    end
  end
end
