const asyncHandler = require("../middleware/async");
const Category = require("../models/category");


exports.getCategories = asyncHandler(async (req, res, next) => {
  try {
    const category = await Category.find({});
    res.status(200).json({
      success: true,
      count: category.length,
      data: category,
    });
  } catch (err) {
    res.status(400).json({ success: false });
  }
});

// @desc    Get single batch
// @route   GET /api/v1/batches/:id
// @access  Public

exports.getCategory = asyncHandler(async (req, res, next) => {
  const category = await Category.findById(req.params.id);
  if (!category) {
    return res
      .status(404)
      .json({ message: "Category not found with id of ${req.params.id}" });
  } else {
    res.status(200).json({
      success: true,
      data: category,
    });
  }
});



exports.createCategory = asyncHandler(async (req, res, next) => {
  try {
    const category = await Category.create(req.body);

    res.status(201).json({
      success: true,
      data: category,
    });
  } catch (err) {
    res.status(400).json({ success: false });
  }
});



exports.updateCategory = asyncHandler(async (req, res, next) => {
  let category = await Category.findById(req.params.id);

  if (!category) {
    return res
      .status(404)
      .json({ message: "Category not found with id of ${req.params.id}" });
  }

  category = await Category.findByIdAndUpdate(req.params.id, req.body, {
    new: true,
    runValidators: true,
  });

  res.status(200).json({
    success: true,
    data: category,
  });
});

// @desc    Delete batch
// @route   DELETE /api/v1/batches/:id
// @access  Private

// exports.deleteBatch = asyncHandler(async (req, res, next) => {
//   const batch = await Batch.findById(req.params.id);

//   if (!batch) {
//     return res
//       .status(404)
//       .json({ message: "Batch not found with id of ${req.params.id}" });
//   }

//   batch.remove();

//   res.status(200).json({
//     success: true,
//     data: {},
//   });
// });

exports.deleteCategory = async (req, res, next) => {
  // delete course by id
  await Category.findByIdAndDelete(req.params.id).then((category) => {
    if (!category) {
      return res
        .status(404)
        .json({ message: "Category not found with id of ${req.params.id}" });
    }
    res.status(200).json({ success: true, data: category });
  });
};
