require "conductor/config"
require "conductor/engine"
require "tubesock"

module Conductor
  CONTAINER = :__conductor_container__
  EDITOR = :__conductor_editor__
  VIEW_FILENAME = :__conductor_view_filename__
  PARTIAL_FILENAMES = :__conductor_partial_filenames__
end
