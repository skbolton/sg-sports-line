const makeEventClient = api => {
  const all = () =>
    api.get("/events/all")

  const create = params =>
    api.post("/events", {event: params})

  return {
    all,
    create
  }
}

export default makeEventClient
