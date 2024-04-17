variables([Users, Access]).

def_type(users, set(user)).
def_type(access, rel(timestamp, user)).

invariant(invState).
dec_p_type(invState(users, access)).
invState(Users, Access) :-
    dec(X, set(user)) &
    set(Users) &
    pfun(Access) &
    ran(Access, X) &
    subset(X, Users).

dec_p_type(n_invState(users, access)).
n_invState(Users, Access) :-
    dec(X, set(user)) &
    ran(Access, X) &
    neg(
        set(Users) &
        pfun(Access) &
        subset(X, Users)
    ).

initial(initialState).
dec_p_type(initialState(users, access)).
initialState(Users, Access) :-
    Users = {} &
    Access = {}.

dec_p_type(addUserOk(users, access, user, response, users, access)).
addUserOk(Users, Access, User_i, Response_o, Users_, Access_) :-
    User_i nin Users &
    un(Users, {User_i}, Users_) &
    Access_ = Access &
    Response_o = response:ok.

dec_p_type(addUserAlreadyExists(users, access, user, response, users, access)).
addUserAlreadyExists(Users, Access, User_i, Response_o, Users_, Access_) :-
    User_i in Users &
    Users_ = Users &
    Access_ = Access &
    Response_o = response:userAlreadyExists.

operation(addUser).
dec_p_type(addUser(users, access, user, response, users, access)).
addUser(Users, Access, User_i, Response_o, Users_, Access_) :-
    addUserOk(Users, Access, User_i, Response_o, Users_, Access_)
    or
    addUserAlreadyExists(Users, Access, User_i, Response_o, Users_, Access_).

dec_p_type(removeUserOk(users, access, user, response, users, access)).
removeUserOk(Users, Access, User_i, Response_o, Users_, Access_) :-
    User_i in Users &
    diff(Users, {User_i}, Users_) &
    rares(Access, {User_i}, Access_) &
    Response_o = response:ok.

dec_p_type(removeUserDoesNotExist(users, access, user, response, users, access)).
removeUserDoesNotExist(Users, Access, User_i, Response_o, Users_, Access_) :-
    User_i nin Users &
    Users_ = Users &
    Access_ = Access &
    Response_o = response:userDoesNotExist.

operation(removeUser).
dec_p_type(removeUser(users, access, user, response, users, access)).
removeUser(Users, Access, User_i, Response_o, Users_, Access_) :-
    removeUserOk(Users, Access, User_i, Response_o, Users_, Access_)
    or
    removeUserDoesNotExist(Users, Access, User_i, Response_o, Users_, Access_).

dec_p_type(validateAccessOk(users, access, user, timestamp, response, users, access)).
validateAccessOk(Users, Access, User_i, Timestamp_i, Response_o, Users_, Access_) :-
    dec(X, set(timestamp)) &
    User_i in Users &
    dom(Access, X) &
    Timestamp_i nin X &
    Users_ = Users &
    oplus(Access, {[Timestamp_i, User_i]}, Access_) &
    Response_o = response:ok.

dec_p_type(validateAccessUserDoesNotHaveAccess(users, access, user, response, users, access)).
validateAccessUserDoesNotHaveAccess(Users, Access, User_i, Response_o, Users_, Access_) :-
    User_i nin Users &
    Users_ = Users &
    Access_ = Access &
    Response_o = response:userDoesNotHaveAccess.

dec_p_type(validateAccessTimestampAlreadyExists(users, access, user, timestamp, response, users, access)).
validateAccessTimestampAlreadyExists(Users, Access, User_i, Timestamp_i, Response_o, Users_, Access_) :-
    dec(X, set(timestamp)) &
    User_i in Users &
    dom(Access, X) &
    Timestamp_i in X &
    Users_ = Users &
    Access_ = Access &
    Response_o = response:timestampAlreadyExists.

operation(validateAccess).
dec_p_type(validateAccess(users, access, user, timestamp, response, users, access)).
validateAccess(Users, Access, User_i, Timestamp_i, Response_o, Users_, Access_) :-
    validateAccessOk(Users, Access, User_i, Timestamp_i, Response_o, Users_, Access_)
    or
    validateAccessUserDoesNotHaveAccess(Users, Access, User_i, Response_o, Users_, Access_)
    or
    validateAccessTimestampAlreadyExists(Users, Access, User_i, Timestamp_i, Response_o, Users_, Access_).