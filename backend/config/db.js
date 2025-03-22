const mongoose = require("mongoose")

const connectDB = async () => {
  try {
    await mongoose.connect(process.env.MONGO_URI)

    if (process.env.NODE_ENV !== "test") {
      console.log("✅ MongoDB Connected")
    }
  } catch (error) {
    console.error("MongoDB Connection Error:", error)

    // Prevent Jest from crashing due to process.exit(1)
    if (process.env.NODE_ENV !== "test") {
      process.exit(1)
    } else {
      throw new Error("DB connection failed")
    }
  }
}

module.exports = connectDB
