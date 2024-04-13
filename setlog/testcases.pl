dec(U0, users) & dec(U1, users) & dec(U2, users) & dec(U3, users)
& dec(A0, access) & dec(A1, access) & dec(A2, access) & dec(A3, access)
& dec(X1, response) & dec(X2, response) & dec(X3, response) & dec(X4, response)
& initialState(U0, A0)
& addUser(U0, A0, user:1, X1, U1, A1)
& addUser(U1, A1, user:2, X2, U2, A2)
& validateAccess(U2, A2, user:1, timestamp:1, X3, U3, A3).

# U0 = {},
# U1 = {user:1},
# U2 = {user:1,user:2},
# U3 = {user:1,user:2},
# A0 = {},
# A1 = {},
# A2 = {},
# A3 = {[timestamp:1,user:1]},
# X1 = response:ok,
# X2 = response:ok,
# X3 = response:ok

initialState(U0, A0)
& addUser(U0, A0, user:1, X1, U1, A1)
& addUser(U1, A1, user:2, X2, U2, A2)
& validateAccess(U2, A2, user:1, timestamp:11, X3, U3, A3)
& validateAccess(U3, A3, user:1, timestamp:11, X4, U4, A4)
& validateAccess(U4, A4, user:3, timestamp:12, X5, U5, A5)
& removeUser(U5, A5, user:1, X6, U6, A6).

# U0 = {},
# A0 = {},
# X1 = response:ok,
# U1 = {user:1},
# A1 = {},
# X2 = response:ok,
# U2 = {user:1,user:2},
# A2 = {},
# X3 = response:ok,
# U3 = {user:1,user:2},
# A3 = {[timestamp:11,user:1]},
# X4 = response:timestampAlreadyExists,
# U4 = {user:1,user:2},
# A4 = {[timestamp:11,user:1]},
# X5 = response:userDoesNotHaveAccess,
# U5 = {user:1,user:2},
# A5 = {[timestamp:11,user:1]},
# X6 = response:ok,
# U6 = {user:2/_N1},
# A6 = {}
# Constraint: subset(_N1,{user:1,user:2}), user:1 nin _N1, set(_N1)