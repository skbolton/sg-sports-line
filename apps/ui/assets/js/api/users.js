const makeUserClient = api => {
  const login = (email, password) =>
    api.post("/sessions", { email, password})

  return {
    login
  }
}

export default makeUserClient
