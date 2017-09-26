defmodule Addict.AddictView do
  use Phoenix.HTML
  use Phoenix.View, root: "lib/cmr_web/templates/"
  import Phoenix.Controller, only: [view_module: 1]
  import CmrWeb.Router.Helpers
end
