const app = require('./app');
const userService = require('./app/services/userService');
const PORT = process.env.PORT || 3000;


// // Sử dụng userService
// userService.getUserById(1)
//   .then(user => console.log(user))
//   .catch(error => console.error(error));

// userService.getAllUsers()
//   .then(users => console.log(users))
//   .catch(error => console.error(error));
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});