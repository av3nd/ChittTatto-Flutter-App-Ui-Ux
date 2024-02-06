const express = require("express");
const foodRouter = express.Router();
const { protect } = require("../middleware/auth");
const uploadFP = require("../middleware/uploadFP");

const {
    addFood,
    getAllFood,
    getOrders,
    changeOrderStatus,
    getFood,
    searchFood,
    rateFood,
    searchByCategory,
    getDealOfTheDay,
    deleteFood,
    updateFood,
    getFoodById,
    uploadFoodImage
  } = require("../controllers/food");

  foodRouter.post("/uploadFoodImage", uploadFP, uploadFoodImage);

  foodRouter.post("/add-food",protect,addFood)
  foodRouter.get("/get-all-foods",getAllFood)
  foodRouter.get("/get-orders",protect,getOrders)
  foodRouter.post("/change-order-status",protect,changeOrderStatus)
  foodRouter.get("/get-food",protect,getFood)
  foodRouter.get("/search-food/:name",searchFood)
  foodRouter.post("/rate-food",protect,rateFood)
  foodRouter.get("/deal-of-day",protect,getDealOfTheDay)
  foodRouter.delete("/deleteFood/:id",protect , deleteFood);
  foodRouter.put("/updateFood/:id", protect, updateFood);
  foodRouter.get("/getFoodById/:id", protect, getFoodById);

  foodRouter.get("/getFoodsByCategory/:categoryId", protect, searchByCategory);

  module.exports = foodRouter;
