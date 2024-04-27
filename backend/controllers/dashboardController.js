// DEPENDENCIES
const express = require("express");
const router = express.Router();
const {
  getUserProfile,
  getFriendsAndTheirWishlists,
} = require("../queries/dashboardQuery");

// GET USER PROFILE, FRIENDS, AND FRIENDS WISHLISTS
router.get("/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const userProfile = await getUserProfile(id);
    const friends = await getFriendsAndTheirWishlists(id);
    res.status(200).json({ userProfile, friends });
  } catch (e) {
    res.status(500).json({ message: `Error: ${e}` });
  }
});

router.get("*", async (req, res) => {
  try {
    res.send(
      "Welcome to Dashboard, Welcome to Dashboard, Welcome to Dashboard, Welcome to Dashboard!"
    );
  } catch (e) {
    res.status(500).json({ message: `Error: ${e}` });
  }
});

// EXPORT
module.exports = router;
