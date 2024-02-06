const mongoose = require("mongoose");
const ratingSchema = require("./rating");

const foodSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true,
  },
  description: {
    type: String,
    required: true,
    trim: true,
  },
  image:
    {
      type: String
    },
 
  quantity: {
    type: Number,
    required: true,
  },
  price: {
    type: Number,
    required: true,
  },
  category: {
    type: mongoose.Schema.ObjectId,
    ref: "Category",
  },
  ratings: [ratingSchema],
});

const Food = mongoose.model("Food", foodSchema);
module.exports = { Food, foodSchema };