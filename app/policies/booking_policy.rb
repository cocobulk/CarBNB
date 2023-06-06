class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.where(user: user)
    # end
  end

  def index
    record.user == user
  end

  def show?
    record.user == user
  end

  def new?
    create?
  end

  def create?
    true
  end

  def edit?
    update?
  end

  def update?
    record.car.user == user
  end

  def destroy?
    record.user == user
  end
end
