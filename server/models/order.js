const mongoose = require("mongoose");
const { foodSchema } = require("./food");

const orderSchema = mongoose.Schema({
  foods: [
    {
      type: foodSchema,
     required: true
    },
  ],
  totalPrice: {
    type: Number,
    required: true,
  },
  address: {
    type: String,
    required: true,
  },
  userId: {
    required: true,
    type: String,
  }
});

const Order = mongoose.model("Order", orderSchema);
module.exports = Order;