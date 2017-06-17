class Ability
  include CanCan::Ability

  def initialize(user, project_id=nil)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    
    # -- My -- start --
    user ||= User.new # guest user (not logged in)
    if user.superadmin_role?
      can :manage, :all
      can :access, :rails_admin   # only allow admin users to access Rails Admin
      can :dashboard              # allow access to dashboard
    end
    
    if user.manager_role?
      can :read, :all 
      can :manage, Project
      can :manage, Document
      can :manage, Wiki
      can :manage, Discussion
      can [:new, :create, :edit, :update], Post
    end
    
    if user.user_role?
      can :read, :all 
      if user.projects.find_by_id(project_id)
        can :manage, Document
        can :manage, Wiki
        can [:new, :create], Post
        can [:edit, :update], Post.where(creator: user.id)
        #can :update, Post.where(creator: user.id)
        #user.projects.find_by_id(project_id).
        #u.projects.find_by_id(8).discussions.find_by_id(3).posts.find_by_creator(u.id)
        #user.projects.find_by_id(project_id).discussions.find_by_id(discussion_id).posts.find_by_creator(user.id)
        
      end
    end
    
  end
end
