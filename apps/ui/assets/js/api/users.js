const makeUserClient = api => {
  const login = (email, password) =>
    api.post("/sessions", { email, password})

  const create = (email, password) =>
    api.post("/users", {email: email, password: password})

  return {
    login,
    create
  }
}

export default makeUserClient
