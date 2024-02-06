const asyncHandler = require("../middleware/async");

const { Food } = require("../models/food");

const Order = require("../models/order");
const path = require("path");
const fs = require("fs");


//admin
exports.addFood = asyncHandler(async (req, res, next) => {
  const food = await Food.findOne({ name: req.body.name });
  if (food) {
    return res.status(400).send({ message: "Food already exists" });
  }

  //   const batch = await Batch.findOne({ _id: req.body.batch });
  //   if (!batch) {
  //     return res.status(400).send({ message: "Invalid Batch" });
  //   }
  await Food.create(req.body);

  res.status(200).json({
    success: true,
    message: "Food created successfully",
  });
});

// exports.register = asyncHandler(async (req, res, next) => {
//   const user = await User.findOne({ email: req.body.email });
//   if (user) {
//     return res.status(400).send({ message: "User already exists" });
//   }

//   //   const batch = await Batch.findOne({ _id: req.body.batch });
//   //   if (!batch) {
//   //     return res.status(400).send({ message: "Invalid Batch" });
//   //   }
//   await User.create(req.body);

//   res.status(200).json({
//     success: true,
//     message: "User created successfully",
//   });
// });
exports.uploadFoodImage = asyncHandler(async (req, res, next) => {
  // // check for the file size and send an error message
  // if (req.file.size > process.env.MAX_FILE_UPLOAD) {
  //   return res.status(400).send({
  //     message: `Please upload an image less than ${process.env.MAX_FILE_UPLOAD}`,
  //   });
  // }

  if (!req.file) {
    return res.status(400).send({ message: "Please upload a file" });
  }
  res.status(200).json({
    success: true,
    data: req.file.filename,
  });
});
exports.getAllFood = asyncHandler(async (req, res, next) => {
  try {
    const foods = await Food.find({});
    res.json(foods);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


exports.getOrders = asyncHandler(async (req, res, next) => {
  try {
    const orders = await Order.find({});
    res.json(orders);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

exports.changeOrderStatus = asyncHandler(async (req, res, next) => {
  try {
    const { id, status } = req.body;
    let order = await Order.findById(id);
    order.status = status;
    order = await order.save();
    res.json(order);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


// user
exports.getFood = asyncHandler(async (req, res, next) => {
    try {
        const foods = await Food.find({ category: req.query.category });
        res.json(foods);
      } catch (e) {
        res.status(500).json({ error: e.message });
      }
  });

  exports.searchFood = asyncHandler(async (req, res, next) => {
    try {
        const foods = await Food.find({
          name: { $regex: req.params.name, $options: "i" },
        });
    
        res.json(foods);
      } catch (e) {
        res.status(500).json({ error: e.message });
      }
  });

  exports.rateFood = asyncHandler(async (req, res, next) => {
    try {
        const { id, rating } = req.body;
        let food = await Food.findById(id);
    
        for (let i = 0; i < food.ratings.length; i++) {
          if (product.ratings[i].userId == req.user) {
            product.ratings.splice(i, 1);
            break;
          }
        }
    
        const ratingSchema = {
          userId: req.user,
          rating,
        };
    
        product.ratings.push(ratingSchema);
        product = await product.save();
        res.json(product);
      } catch (e) {
        res.status(500).json({ error: e.message });
      }
  });

  

  exports.getDealOfTheDay = asyncHandler(async (req, res, next) => {
    try {
        let foods = await Food.find({});
    
        foods = foods.sort((a, b) => {
          let aSum = 0;
          let bSum = 0;
    
          for (let i = 0; i < a.ratings.length; i++) {
            aSum += a.ratings[i].rating;
          }
    
          for (let i = 0; i < b.ratings.length; i++) {
            bSum += b.ratings[i].rating;
          }
          return aSum < bSum ? 1 : -1;
        });
    
        res.json(foods[0]);
      } catch (e) {
        res.status(500).json({ error: e.message });
      }
  });

  exports.deleteFood = asyncHandler(async (req, res, next) => {
    console.log(req.params.id);
    Food.findByIdAndDelete(req.params.id)
      .then((food) => {
        if (food != null) {
          var imagePath = path.join(
            __dirname,
            "..",
            "public",
            "foodPictures",
            food.image
          );
  
          fs.unlink(imagePath, (err) => {
            if (err) {
              console.log(err);
            }
            res.status(200).json({
              success: true,
              message: "Food deleted successfully",
            });
          });
        } else {
          res.status(400).json({
            success: false,
            message: "Food not found",
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
  

  exports.updateFood = asyncHandler(async (req, res, next) => {
    const user = req.body;
    const food = await Food.findByIdAndUpdate(req.params.id, user, {
      new: true,
      runValidators: true,
    });
  
    if (!food) {
      return res.status(404).send({ message: "food not found" });
    }
  
    res.status(200).json({
      success: true,
      message: "Food updated successfully",
      data: food,
    });
  });

  exports.searchByCategory = asyncHandler(async (req, res, next) => {
    // // const foods = await Food.find({ category: req.params.categoryId });
    // // if (!foods) {
    // //   return res.status(404).send({ message: "No foods found" });
    // // }
    // // res.status(201).json({
    // //   success: true,
    // //   count: foods.length,
    // //   data: foods,
    // });
  
    const categoryId = req.params.categoryId;
    Food.find({ category: categoryId })
      .populate("category", "-__v")
      // .select("-quantity -__v")

      .then((food) => {
        res.status(201).json({
          success: true,
          message: "List of Foods by category",
          data: food,
        });
      })
      .catch((err) => {
        res.status(500).json({
          success: false,
          message: err,
        });
      });
  });
  

  exports.getFoodById = asyncHandler(async (req, res, next) => {
    const foodId = req.params.id;
  
    try {
      const food = await Food.findById(foodId);
  
      if (!food) {
        return res.status(404).json({
          error: 'Food not found',
        });
      }
  
      res.status(200).json({
        food,
      });
    } catch (error) {
      // Handle any potential errors that might occur during the database query
      res.status(500).json({
        error: 'Internal Server Error',
      });
    }
  });
  