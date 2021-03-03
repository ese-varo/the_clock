class BaseDecorator < SimpleDelegator
  def decorate(model, decorate_class = nil)
    ApplicationController.helpers.decorate(mnodel, decorate_class)
  end
end
