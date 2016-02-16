class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    if user.admin?
      can :read, :all
    elsif user.user?
      can :read, :all
      can :update, User, id: user.id
      cannot :read, User
    else
      can :read, :all
      can :create, User
      cannot :read, User
    end
  end
end
