defmodule Web.API.PageController do
  use Web.API.Web, :controller

  def index(conn, _params) do
    render conn, "index.html",
      sum: :maths.sum(9, 3),
      diff: :maths.diff(3, 5),
      genseq: :maths.genseq(3, 13),
      doseqcom: :maths.doseqcomp(9)
  end
end
