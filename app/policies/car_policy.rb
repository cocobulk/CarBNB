class CarPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  # @dev Anyone can create (rent) their car.
  def new?
    create?
  end

  def create?
    true
  end

 # @dev Only the owner of the car can edit/destroy it.
  def edit?
    update?
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

end
