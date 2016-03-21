class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :read, :all
      can :update, User, id: user.id
    elsif user.user?
      can :update, User, id: user.id
      can :read, User, id: user.id
    elsif user.role.nil?
      can :create, User
      cannot :read, User
    end
  end
end
