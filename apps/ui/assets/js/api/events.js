const makeEventClient = api => {
  const allEvents = () =>
    api.get("/admin/events")

  return {
    allEvents
  }
}

export default makeEventClient
