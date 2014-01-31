module Conductor
  class Filter
    def self.before(controller)
#   (controller.flash[Conductor::SPEC] ||= '') << controller.params.delete(Conductor::SPEC) if controller.params[Conductor::SPEC]
      controller.flash[Conductor::SPEC] = controller.params.delete Conductor::SPEC if controller.params[Conductor::SPEC]
      controller.flash.keep Conductor::SPEC
    end
  end
end
