const makeEventClient = api => {
  const allEvents = () =>
    api.get("/admin/events")

  const create = params =>
    api.post("/events", {event: params})

  return {
    allEvents,
    create
  }
}

export default makeEventClient
