const mongoose = require("mongoose");

const categorySchema = new mongoose.Schema({
  categoryName: {
    type: String,
    required: [true, "Please add a food category name"],
    unique: true,
    trim: true,
    maxlength: [20, "category name can not be more than 20 characters"],
  },
});

module.exports = mongoose.model("Category", categorySchema);
