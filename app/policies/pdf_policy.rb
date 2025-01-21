class PdfPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end

  def index?
    true
  end

  def show?
    user.admin? || record.user == user
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    user.admin? || record.user == user
  end

  def destroy?
    user.admin? || record.user == user
  end

  def delete_selected?
    true
  end

  def download?
    show?
  end

  def view?
    show?
  end
end 