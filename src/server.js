const express = require('express');
const path = require('path');
const morgan = require('morgan');
const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(morgan('combined'));
app.use(express.static(path.join(__dirname, 'public')));

// Routes
app.get('/health', (req, res) => res.json({ 
  status: 'UP', 
  timestamp: new Date().toISOString() 
}));

// Start server
app.listen(PORT, '0.0.0.0', () => {
  console.log(`✅ Server running on http://0.0.0.0:${PORT}`);
});