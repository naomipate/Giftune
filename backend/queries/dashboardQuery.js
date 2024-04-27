const db = require("../db/dbConfig");

// GET USER PROFILE
const getUserProfile = async (id) => {
  // user shown in nav
  const user = await db.one("SELECT * FROM users WHERE id=$1", id);
  return user;
};

const getFriendsAndTheirWishlists = async (id) => {
  // Friends
  const requests = await db.any(
    "SELECT * FROM friends_list WHERE curr_user_id=$1 OR other_user_id=$1",
    id
  );
  // comparing to confirm friendship
  let usersRequest = requests
    .filter((userRequest) => userRequest.curr_user_id === Number(id))
    .map((request) => request.other_user_id);

  let friendsRequest = requests
    .filter((friendRequest) => friendRequest.other_user_id === Number(id))
    .map((request) => request.curr_user_id);

  // friendship confirmed and pushed into array for Friends list
  let connectionIds = [];
  for (let requestId of usersRequest) {
    if (friendsRequest.includes(requestId)) {
      connectionIds.push(requestId);
    }
  }

  // Ordering friends list by DOB
  let userConnections = await db.any(
    "SELECT * FROM users WHERE id in ($1:csv) ORDER BY dob ASC",
    [connectionIds]
  );

  // Grabbing friends' wishlists by user_id
  for (let connection of userConnections) {
    let wishlist = await db.any(
      "SELECT * FROM wishlist WHERE user_id=$1",
      connection.id
    );
    connection.wishlist = wishlist;
  }

  return userConnections;
};

module.exports = {
  getUserProfile,
  getFriendsAndTheirWishlists,
};
