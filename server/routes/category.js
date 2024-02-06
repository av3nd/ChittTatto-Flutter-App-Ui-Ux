const express = require("express");
const router = express.Router();
const { protect } = require("../middleware/auth");

const {
  getCategories,
  getCategory,
  createCategory,
  updateCategory,
  deleteCategory,
} = require("../controllers/category");

router.get("/getAllCategories", getCategories);
router.get("/:id", getCategory);

router.post("/createCategory", createCategory);
router.put("/:id", protect, updateCategory);
router.delete("/:id", protect, deleteCategory);

module.exports = router;
