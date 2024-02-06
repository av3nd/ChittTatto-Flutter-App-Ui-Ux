const asyncHandler = require("../middleware/async");
const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken')
const { Food } = require("../models/food");
const Order  = require("../models/order");


const User = require("../models/user");
const path = require("path");
const fs = require("fs");


// @desc    Get all students
// @route   GET /api/v1/students
// @access  Private

exports.getUsers = asyncHandler(async (req, res, next) => {
  const users = await User.find({});
  res.status(200).json({
    success: true,
    count: users.length,
    data: users,
  });
});

// @desc    Get single student
// @route   GET /api/v1/students/:id
// @access  Private

exports.getUser = asyncHandler(async (req, res, next) => {
  const user = await User.findById(req.params.id);
  if (!user) {
    return res
      .status(404)
      .json({ message: "User not found with id of ${req.params.id}" });
  } else {
    res.status(200).json({
      success: true,
      data: user,
    });
  }
});

// @desc    Create new student
// @route   POST /api/v1/students
// @access  Public

exports.register = asyncHandler(async (req, res, next) => {
  const user = await User.findOne({ email: req.body.email });
  if (user) {
    return res.status(400).send({ message: "User already exists" });
  }

  //   const batch = await Batch.findOne({ _id: req.body.batch });
  //   if (!batch) {
  //     return res.status(400).send({ message: "Invalid Batch" });
  //   }
  await User.create(req.body);

  res.status(200).json({
    success: true,
    message: "User created successfully",
  });
});



exports.login = asyncHandler(async (req, res, next) => {
  const { email, password } = req.body;
  User.findOne({ email })
    .then((user) => {
      if (!user)
        return res.status(401).json({ error: "User is not registered" });

      bcrypt.compare(password, user.password, (err, success) => {
        if (err) return res.status(500).json({ error: err.message });
        if (!success)
          return res.status(401).json({ error: "password does not match" });

        const payload = {
          id: user._id,
          email: user.email,
          type: user.type,
        };

        jwt.sign(
          payload,
          process.env.JWT_SECRET,
          { expiresIn: "1d" },
          (err, encoded) => {
            if (err) res.status(500).json({ error: err.message });
            res.json({
              email: user.email,
              token: encoded,
            });
          }
        );
      });
    })
    .catch(next);
});

exports.checkUser = asyncHandler(async (req, res, next) => {
  User.findOne({ email: req.body.email })

    .then((user) => {
      if (!user) return res.status(400).json({ error: "User not found" });

      if (user.email == "admin@gmail.com")
        return res.status(201).json({ message: "Admin found" });

      res.status(200).json(user);
    })
    .catch(next);
});


exports.getMe = asyncHandler(async (req, res, next) => {
  // Show current user
  const user = await User.findById(req.params.id);

  res.status(200).json({
    user
  });
});




exports.updateUser = asyncHandler(async (req, res, next) => {
  const use = req.body;
  const user = await User.findByIdAndUpdate(req.params.id, use, {
    new: true,
    runValidators: true,
  });

  if (!user) {
    return res.status(404).send({ message: "User not found" });
  }

  res.status(200).json({
    success: true,
    message: "User updated successfully",
    data: user,
  });
});

// @desc    Delete student
// @route   DELETE /api/v1/students/:id
// @access  Private

exports.deleteUser = asyncHandler(async (req, res, next) => {
  console.log(req.params.id);
  User.findByIdAndDelete(req.params.id)
    .then((user) => {
      if (user != null) {
        var imagePath = path.join(
          __dirname,
          "..",
          "public",
          "uploads",
          user.image
        );

        fs.unlink(imagePath, (err) => {
          if (err) {
            console.log(err);
          }
          res.status(200).json({
            success: true,
            message: "Student deleted successfully",
          });
        });
      } else {
        res.status(400).json({
          success: false,
          message: "Student not found",
        });
      }
    })
    .catch((err) => {
      res.status(500).json({
        success: false,
        message: err.message,
      });
    });
});

// @desc Upload Single Image
// @route POST /api/v1/auth/upload
// @access Private

exports.uploadImage = asyncHandler(async (req, res, next) => {

  if (!req.file) {
    return res.status(400).send({ message: "Please upload a file" });
  }
  res.status(200).json({
    success: true,
    data: req.file.filename,
  });
});




//orders
// exports.addToCart = asyncHandler(async (req, res, next) => {
//   try {
//     const { food } = req.body; // Assuming you are now passing the entire Food object in the request body
//     const user = await User.findById(req.params.id);

//     if (!food) {
//       return res.status(400).json({ error: 'Invalid food data' });
//     }

//     if (!user) {
//       return res.status(404).json({ error: 'User not found' });
//     }

//     if (!user.cart) {
//       // Initialize the cart if it's not already set
//       user.cart = [];
//     }

//     if (user.cart.length === 0) {
//       user.cart.push({ 
//         name: food.name,
//         description: food.description,
//         price: food.price,
//         quantity: 1 
//       });
//     } else {
//       let isFoodFound = false;
//       for (let i = 0; i < user.cart.length; i++) {
//         if (user.cart[i].name === food.name) {
//           isFoodFound = true;
//           break; // Added break to exit the loop early once found
//         }
//       }

//       if (isFoodFound) {
//         let foodItem = user.cart.find((item) => item.name === food.name);
//         foodItem.quantity += 1;
//       } else {
//         user.cart.push({ 
//           name: food.name,
//           description: food.description,
//           price: food.price,
//           quantity: 1 
//         });
//       }
//     }

//     const updatedUser = await user.save();
//     // Return the updated cart array from the server response
//     res.json(updatedUser.cart);
//   } catch (e) {
//     res.status(500).json({ error: e.message });
//   }
// });
exports.getCurrentUserId = (req, res) => {
  const authorizationHeader = req.headers.authorization;

  if (!authorizationHeader || !authorizationHeader.startsWith('Bearer ')) {
    return res.status(401).json({ error: 'User is not logged in or token is not provided' });
  }

  const token = authorizationHeader.replace('Bearer ', '');

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    return res.json({ userId: decoded.id });
  } catch (err) {
    return res.status(401).json({ error: 'Invalid or expired token' });
  }
};


exports.addToCart = asyncHandler(async (req, res, next) => {
  try {
    const { food } = req.body; // Assuming you are now passing the entire Food object in the request body
    const user = await User.findById(req.user);

    if (!food) {
      return res.status(400).json({ error: 'Invalid food data' });
    }

    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    if (!user.cart) {
      // Initialize the cart if it's not already set
      user.cart = [];
    }

    // Check if the food item exists in the database
    const existingFood = await Food.findById(food._id);
    if (!existingFood) {
      return res.status(400).json({ error: 'Food item does not exist' });
    }

    // Check if the food item is already in the cart based on its unique _id
    const existingCartItem = user.cart.find((item) => item.food.equals(food._id));

    if (existingCartItem) {
      existingCartItem.quantity += 1;
    } else {
      user.cart.push({
        food: {
          "foodId":food._id,
          "image":food.image,
          "name": food.name,
          "description": food.description,
          "price": food.price,
          "quantity":food.quantity

      },
      });
    }

    const updatedUser = await user.save();
    res.json(updatedUser.cart);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

exports.getAllCart = asyncHandler(async (req, res, next) => {
  try {
    const user = await User.findById(req.user);
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    res.status(200).json({
      success: true,
      count: user.cart.length,
      data: user.cart,
    });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

exports.removeFromCart = asyncHandler(async (req, res, next) => {
  try {
    const { id } = req.params;
    const user = await User.findById(req.user);

    // Find the index of the cart item with the given _id
    const cartItemIndex = user.cart.findIndex(item => item._id.toString() === id);

    // If the cart item is found, remove it from the user's cart
    if (cartItemIndex !== -1) {
      user.cart.splice(cartItemIndex, 1);
      await user.save();
      res.json({ success: true, message: 'Item removed from cart' });
    } else {
      // If the cart item with the given _id is not found, return an error
      res.status(404).json({ success: false, error: 'Food not found in cart' });
    }
  } catch (e) {
    res.status(500).json({ success: false, error: e.message });
  }
});


exports.saveUserAddress = asyncHandler(async (req, res, next) => {

  try {
    const { address } = req.body;
    let user = await User.findById(req.user);
    user.address = address;
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


exports.createOrder = asyncHandler(async (req, res, next) => {
  try {
    const { cart, totalPrice, address } = req.body;
    console.log("Received cart:", cart);
    console.log("Received totalPrice:", totalPrice);
    console.log("Received address:", address);
    let foods = [];

    for (let i = 0; i < cart.length; i++) {
      console.log("Cart item:", cart[i]);

      if (!cart[i].food) {
        console.log("Food object is undefined for cart item:", cart[i]);
        return res.status(400).json({ msg: "Food object is missing in the cart item." });
      }

      const foodName = cart[i].food.name;

      // Find the food in the database based on the name (assuming name is unique)
      const food = await Food.findOne({ name: foodName });

      console.log("Found food:", food);

      if (!food) {
        return res
          .status(400)
          .json({ msg: `Food with name '${foodName}' not found!` });
      }

      foods.push(food);
    }    

    console.log("Processed foods:", foods);

    let user = await User.findById(req.user);
    user.cart = [];
    user = await user.save();

    const order = new Order({
      foods,
      totalPrice,
      address,
      userId: req.user.id,
      orderedAt: new Date().getTime(),
    });

    // Save the order to the database
    await order.save();

    res.json(order);
  } catch (e) {
    console.error("Error:", e.message);
    res.status(500).json({ error: "An error occurred while processing the request." });
  }
});


exports.deleteOrder = asyncHandler(async (req, res, next) => {
  try {
    const orderId = req.params.id;

    // Find the order by orderId
    const order = await Order.findById(orderId);

    // If the order doesn't exist, return an error
    if (!order) {
      return res.status(404).json({ error: "Order not found" });
    }

    // Delete the order
    await Order.findByIdAndDelete(orderId);

    res.json({ success: true, message: "Order deleted successfully" });
  } catch (e) {
    console.error("Error deleting order:", e);
    res.status(500).json({ error: "An error occurred while deleting the order" });
  }
});



exports.allOrders = asyncHandler(async (req, res, next) => {
  try {
    const orders = await Order.find({});
    res.json(orders);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


// Get token from model , create cookie and send response
const sendTokenResponse = (User, statusCode, res) => {
  const token = User.getSignedJwtToken();

  const options = {
    //Cookie will expire in 30 days
    expires: new Date(
      Date.now() + process.env.JWT_COOKIE_EXPIRE * 24 * 60 * 60 * 1000
    ),
    httpOnly: true,
  };

  // Cookie security is false .if you want https then use this code. do not use in development time
  if (process.env.NODE_ENV === "proc") {
    options.secure = true;
  }
  //we have created a cookie with a token

  res
    .status(statusCode)
    .cookie("token", token, options) // key , value ,options
    .json({
      success: true,
      token,
    });
};

