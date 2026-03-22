const jwt = require("jsonwebtoken");

module.exports = function(req, res, next) {

  const token = req.header("Authorization");

  if (!token) {
    return res.status(401).json({ message: "Access denied" });
  }

  // Remove "Bearer " prefix if present
  const cleanToken = token.startsWith("Bearer ") ? token.slice(7) : token;

  try {

    const decoded = jwt.verify(cleanToken, process.env.JWT_SECRET);
    req.user = decoded;
    next();

  } catch (error) {
    console.log('DEBUG: Token verification failed:', error.message);
    res.status(400).json({ message: "Invalid token" });

  }

};