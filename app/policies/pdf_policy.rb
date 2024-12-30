class PdfPolicy < ApplicationPolicy
  def show?
    record.user == user
  end

  def download?
    show?
  end

  def view?
    show?
  end

  def destroy?
    show?
  end
end 