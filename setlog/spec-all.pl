dinvariant(invState,invState(Users,Access)).
all_unsat_vc(addUser_pi_invState,inv,invState,addUser_pi_invState(Users,Access,Users,Access,User_i,Response_o,Users_,Access_),addUser(Users,Access,User_i,Response_o,Users_,Access_)).
all_unsat_vc(removeUser_pi_invState,inv,invState,removeUser_pi_invState(Users,Access,Users,Access,User_i,Response_o,Users_,Access_),removeUser(Users,Access,User_i,Response_o,Users_,Access_)).
all_unsat_vc(validateAccess_pi_invState,inv,invState,validateAccess_pi_invState(Users,Access,Users,Access,User_i,Timestamp_i,Response_o,Users_,Access_),validateAccess(Users,Access,User_i,Timestamp_i,Response_o,Users_,Access_)).
