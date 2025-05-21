const express = require('express');
const app = express();
const port = process.env.PORT || 3000;
app.use(express.json());

const users = [
  {
    email: 'user@mail.com',
    password: '12345678'
  }
];

app.get('/', (req, res) => {
  res.send('Selamat datang di Aplikasi Microservice DevOps!');
});

app.post('/login', (req, res) => {
  const { email, password } = req.body;
  
  const user = users.find(u => u.email === email && u.password === password);
  
  if (user) {
    res.status(200).json({ success: true, message: 'Login berhasil' });
  } else {
    res.status(401).json({ success: false, message: 'Email atau password salah' });
  }
});

app.listen(port, () => {
  console.log(`Server berjalan di http://localhost:${port}`);
});
// Test perubahan untuk memicu pipeline CI/CD
// Test perubahan untuk memicu pipeline CI/CD
