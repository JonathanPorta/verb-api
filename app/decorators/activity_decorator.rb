class ActivityDecorator < Draper::Decorator
  delegate :id, :user, :message, :type

  decorates_association :user
  decorates_association :message
end
