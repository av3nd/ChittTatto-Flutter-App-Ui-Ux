const express = require("express");
const router = express.Router();
const { protect } = require("../middleware/auth");

const upload = require("../middleware/uploads");

const {
  getUsers,
  register,
  login,
  updateUser,
  deleteUser,
  uploadImage,
  checkUser,
  getMe,
  addToCart,
  removeFromCart,
  saveUserAddress,
  createOrder,
  allOrders,
  getAllCart,
  getCurrentUserId,
  deleteOrder
} = require("../controllers/user");

router.post("/uploadImage", upload, uploadImage);
router.post("/register", register);
router.post("/login", login);
router.get("/getAllUsers", getUsers);
router.put("/updateUser/:id", protect, updateUser);
router.delete("/deleteUser/:id", protect, deleteUser);
router.post("/checkUser", checkUser);
router.get("/getMe/:id", getMe);
router.post("/add-to-cart",protect,addToCart)
router.delete("/remove-from-cart/:id",protect,removeFromCart)
router.post("/save-user-address",protect,saveUserAddress)
router.post("/order",protect,createOrder)
router.get("/orderMe",protect,allOrders)
router.get("/getAllCart/:id",protect,getAllCart)
router.get("/getCurrentUserId",getCurrentUserId)
router.delete("/deleteOrder/:id",deleteOrder)




module.exports = router;
