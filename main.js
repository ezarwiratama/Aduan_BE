const express = require("express");
const app = express();
const fs = require("fs");
const path = require("path");
const port = 5000;
const { Client, LocalAuth, MessageMedia } = require("whatsapp-web.js");
const qrcode = require("qrcode-terminal");
const http = require("http");
const Message = require("./src/models/Message");
const Contact = require("./src/models/Contact");
const User = require("./src/models/User");
const { Server } = require("socket.io");
const cors = require("cors");
const moment = require("moment");
const mysql = require('mysql2');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const secretKey = '3310'; 

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'whatsapp_message',
});

db.connect((err) => {
  if (err) {
    console.error('Database connection failed:', err);
    return;
  }
  console.log('Connected to MySQL database');
});

const server = http.createServer(app);
const io = new Server(server, {
  cors: {
    origin: "http://localhost:3000",
    methods: ["GET", "POST"],
  },
});

const SESSION_FILE_PATH = "./whatsapp-session.json";
let sessionCfg;
if (fs.existsSync(SESSION_FILE_PATH)) {
  sessionCfg = require(SESSION_FILE_PATH);
}

const client = new Client({
  restartOnAuthFail: true,
  puppeteer: {
    headless: true,
    ignoreHTTPSErrors: true,
    args: [
      "--no-sandbox",
      "--disable-setuid-sandbox",
      "--disable-dev-shm-usage",
      "--disable-accelerated-2d-canvas",
      "--no-first-run",
      "--no-zygote",
      "--single-process",
      "--disable-gpu",
    ],
  },
  authStrategy: new LocalAuth(),
});

client.on("ready", () => {
  console.log("Client is ready!");
});

client.on("message", async (msg) => {
  try {
    const chat = await msg.getChat();
    const personNumber = chat.id.user;
    const lastMessage = chat.lastMessage._data;
    const person = lastMessage.notifyName;
    const date = moment().format("YYYY-MM-DD");
    const timeString = moment().format("HH:mm:ss");

    if (msg.body.startsWith("!p")) {
      // Ekstrak isi pesan setelah trigger "!p"
      const messageContent = msg.body.slice(2).trim();
      let mediaFileName = "";

      // Periksa apakah ada isi pesan setelah "!p"
      if (messageContent.length > 0) {
        msg.reply(
          "Selamat Datang di Layanan Aduan, aduan anda sudah kami terima dan akan segera diproses :)"
        );

        if (msg.hasMedia) {
          const media = await msg.downloadMedia();
          console.log("MEDIA FILE", media.filename)
          const mimeTypes = {
            "image/jpeg": ".jpeg",
            "image/jpg": ".jpg",
            "image/png": ".png",
            "image/gif": ".gif",
            "image/svg+xml": ".svg",
            "video/mp4": ".mp4",
            "video/x-msvideo": ".avi",
            "video/x-matroska": ".mkv",
            "video/quicktime": ".mov",
            "application/msword": ".doc",
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document": ".docx",
            "application/vnd.ms-excel": ".xls",
            "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet": ".xlsx",
            "application/pdf": ".pdf",
            "application/zip": ".zip",
            "application/x-rar-compressed": ".rar",
            "application/x-tar": ".tar",
            "application/x-7z-compressed": ".7z",
            "audio/mpeg": ".mp3",
            "audio/wav": ".wav",
            "audio/ogg": ".ogg",
            "text/plain": ".txt",
            "text/html": ".html",
            "text/css": ".css",
            "text/javascript": ".js",
            "application/json": ".json",
          };
          const extension = mimeTypes[media.mimetype] || ".ts";
          const folder = process.cwd() + "/img/" + personNumber + "_" + person + "/" + date + "/";
          const fileName = media.filename || `ADUAN-${date}-${personNumber}` + msg.id.id + `${extension}`;
          const filePath = path.join(folder, fileName);

          fs.mkdirSync(path.dirname(filePath), { recursive: true });
          fs.writeFileSync(filePath, media.data, "base64");

          mediaFileName = fileName;
        }
        const newMessage = await Message.create({
          phoneNumber: personNumber,
          userName: person,
          message: messageContent,
          date: date,
          hour: timeString,
          pic: "",
          no_pic: "",
          reply_message: "",
          reply_time: "",
          reply_pic: "",
          status: "pending",
          media: mediaFileName,
        });

        console.log("Pesan disimpan ke database:", newMessage.toJSON());
        io.emit("receive_message", newMessage.toJSON());
      } else {
        client.sendMessage(
          msg.from,
          "maaf, pesan tidak boleh kosong setelah '!p'"
        );
      }
    } else if (msg.body.startsWith("!balasadmin")) {
      // Extract the reply message content after the trigger "!balaspesan"
      const match = msg.body.match(/^!balasadmin(\d+)\s+(.+)$/);

      if (match) {
        const originalMessageId = parseInt(match[1], 10); // Convert the ID to an integer
        const replyContent = match[2].trim();

        if (!isNaN(originalMessageId) && replyContent.length > 0) {
          msg.reply("Pesan telah diterima admin, terimakasih dan semangat");

          // Retrieve the original message from the database using the ID
          const originalMessage = await Message.findOne({
            where: { id: originalMessageId },
          });

          if (originalMessage) {
            // Update the original message with the reply content
            originalMessage.reply_pic = replyContent;
            await originalMessage.save();

            console.log(
              "Pesan balasan disimpan ke database:",
              originalMessage.toJSON()
            );
            io.emit("update_message", originalMessage.toJSON());
          } else {
            client.sendMessage(
              msg.from,
              "Tidak dapat menemukan pesan asli untuk dibalas."
            );
          }
        } else {
          client.sendMessage(
            msg.from,
            "maaf, format yang benar adalah !balaspesan<ID> <pesan balasan>"
          );
        }
      } else {
        client.sendMessage(
          msg.from,
          "maaf, format yang benar adalah !balaspesan<ID> <pesan balasan>"
        );
      }
    } else {
      client.sendMessage(
        msg.from,
        "maaf, jika ingin membuat aduan pakai format !p diikuti dengan pesan"
      );
    }
  } catch (err) {
    console.error("Gagal menyimpan pesan ke database:", err);
  }
  console.log(msg.from + ": " + msg.body);
});

client.on("qr", (qr) => {
  qrcode.generate(qr, { small: true });
});

client.on("authenticated", (auth) => {
  console.log("AUTHENTICATED", auth);
});

client.on("auth_failure", (msg) => {
  console.error("AUTHENTICATION FAILURE", msg);
});

client.on("loading_screen", (percent, message) => {
  console.log("LOADING SCREEN", percent, message);
});

client.initialize();

app.use(
  cors({
    origin: "http://localhost:3000",
  })
);
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use('/images', express.static(path.join(__dirname, 'img')));

const authenticateToken = (req, res, next) => {
  const token = req.headers['authorization'] && req.headers['authorization'].split(' ')[1];
  if (!token) return res.sendStatus(403); // Forbidden if no token

  jwt.verify(token, secretKey, (err, user) => {
    if (err) return res.sendStatus(403); // Forbidden if token is invalid
    req.user = user;
    next();
  });
};

// POST
app.post("/send-message", async (req, res) => {
  const data = req.body.data;
  const imageUrl = "http://localhost:5000/images/";
  const number = req.body.phoneNumber + "@c.us";
  const message = req.body.message;

  try {
    if (!data) {
      // If req.body.data is null or undefined, send the message without media
      const response = await client.sendMessage(number, message);
      res.status(200).json({
        status: true,
        response: response,
      });
      io.emit("sentMessage", { number, message });
    } else {
      // If media is present, send it along with the message
      if (data.media !== "") {
        const mediaUrl = `${imageUrl}${data.phoneNumber}_${data.userName}/${data.date}/${data.media}`;
        const media = await MessageMedia.fromUrl(mediaUrl);
        const response = await client.sendMessage(number, media, { caption: message });
        res.status(200).json({
          status: true,
          response: response,
        });
        io.emit("sentMessage", { number, message, mediaUrl });
      } else {
        // If no media, just send the text message
        const response = await client.sendMessage(number, message);
        res.status(200).json({
          status: true,
          response: response,
        });
        io.emit("sentMessage", { number, message });
      }
    }
  } catch (err) {
    res.status(500).json({
      status: false,
      response: err,
    });
  }
});


app.post("/contacts", async (req, res) => {
  const { name, no_handphone, bidang } = req.body;
  try {
    const newContact = await Contact.create({
      name: name,
      no_handphone: no_handphone,
      bidang: bidang,
    });

    res.status(200).json({
      status: true,
      response: newContact,
    });

    io.emit("newContact", newContact.toJSON());
    console.log("newContact", newContact.toJSON());
  } catch (err) {
    console.error("Gagal menyimpan kontak ke database:", err);
    res.status(500).json({
      status: false,
      response: err,
    });
  }
});

app.post('/api/signup', async (req, res) => {
  const { username, password } = req.body;
  try {
    // Cek apakah pengguna sudah ada
    db.query('SELECT * FROM users WHERE username = ?', [username], async (err, results) => {
      if (results.length > 0) {
        return res.status(400).json({ message: 'Username already exists' });
      }

      // Hash password
      const hashedPassword = await bcrypt.hash(password, 10);

      // Masukkan pengguna ke dalam database
      db.query('INSERT INTO users (username, password) VALUES (?, ?)', [username, hashedPassword], (err, results) => {
        if (err) {
          console.error('Error inserting user:', err);
          return res.status(500).json({ message: 'Error registering user' });
        }
        res.status(201).json({ message: 'User registered successfully' });
      });
    });
  } catch (error) {
    console.error('Signup error:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
});

app.post('/api/login', (req, res) => {
  const { username, password } = req.body;
  try {
    // Cek apakah pengguna ada
    db.query('SELECT * FROM users WHERE username = ?', [username], async (err, results) => {
      if (results.length === 0) {
        return res.status(400).json({ message: 'Invalid username or password' });
      }

      const user = results[0];

      // Bandingkan password yang diberikan dengan password hash yang disimpan
      const isMatch = await bcrypt.compare(password, user.password);
      if (!isMatch) {
        return res.status(400).json({ message: 'Invalid username or password' });
      }

      // Generate token
      const token = jwt.sign({ id: user.id, username: user.username }, secretKey, { expiresIn: '1h' });

      res.status(200).json({ message: 'Login successful', token });
    });
  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
});

// GET
app.get("/", (req, res) => {
  res.send("Hello World!");
});

app.get("/messages", async (req, res) => {
  try {
    const messages = await Message.findAll({
      order: [["createdAt", "ASC"]],
    });
    res.status(200).json(messages);
  } catch (err) {
    console.error("Gagal mengambil pesan dari database:", err);
    res.status(500).json({
      status: false,
      response: "Gagal mengambil pesan dari database.",
    });
  }
});

app.get("/contacts", async (req, res) => {
  try {
    const contacts = await Contact.findAll();
    res.status(200).json(contacts);
  } catch (err) {
    console.error("Gagal mengambil pesan dari database:", err);
    res.status(500).json({
      status: false,
      response: "Gagal mengambil pesan dari database.",
    });
  }
});

app.get("/users", async (req, res) => {
  try {
    const users = await User.findAll();
    res.status(200).json(users);
  } catch (err) {
    console.error("Gagal mengambil pesan dari database:", err);
    res.status(500).json({
      status: false,
      response: "Gagal mengambil pesan dari database.",
    });
  }
});

app.get('/api/user', authenticateToken, async (req, res) => {
  try {
    // Fetch user data from the database
    const users = await User.findAll();
    res.status(200).json(users);
  } catch (error) {
    console.error('Error fetching user data:', error.message);
    res.status(500).json({ message: 'Internal server error' });
  }
});

app.get('/protected-route', authenticateToken, (req, res) => {
  res.send('This is a protected route');
});


server.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});

io.on("connection", (socket) => {
  console.log("a user connected :", socket.id);

  socket.on("disconnect", () => {
    console.log("user disconnected");
  });
});

// PUT
app.put("/messages/:id", async (req, res) => {
  const { id } = req.params;
  const { status, pic, no_pic } = req.body;

  try {
    if (!status || !pic || !no_pic) {
      return res.status(400).json({ message: "Invalid input data" });
    }
    const message = await Message.findOne({ where: { id } });

    if (message) {
      message.status = status;
      message.pic = pic;
      message.no_pic = no_pic;
      await message.save();
      res.status(200).json(message);
      io.emit("update_message", message.toJSON());
    } else {
      res.status(404).json({ message: "Message not found" });
    }
  } catch (error) {
    console.error("Error updating message:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

app.put("/message/:id", async (req, res) => {
  const { id } = req.params;
  const { status, reply_message, reply_time } = req.body;

  try {
    if (!status || !reply_message || !reply_time) {
      return res.status(400).json({ message: "Invalid input data" });
    }
    const message2 = await Message.findOne({ where: { id } });

    if (message2) {
      message2.status = status;
      message2.reply_message = reply_message;
      message2.reply_time = reply_time;
      await message2.save();
      res.status(200).json(message2);
      io.emit("update_message", message2);
    } else {
      res.status(404).json({ message: "Message not found" });
    }
  } catch (error) {
    console.error("Error updating message:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

app.put("/contacts/:id", async (req, res) => {
  const { id } = req.params;
  const { name, no_handphone, bidang } = req.body;
  console.log("Request Body:", req.body); 

  try {
    if (!name || !no_handphone || !bidang) {
      return res.status(400).json({ message: "Invalid input data" });
    }
    const updateContact = await Contact.findOne({ where: { id } });

    if (updateContact) {
      updateContact.name = name;
      updateContact.no_handphone = no_handphone;
      updateContact.bidang = bidang;
      await updateContact.save();
      res.status(200).json(updateContact);
      io.emit("update_contact", updateContact.toJSON());
    } else {
      res.status(404).json({ message: "Contact not found" });
    }
  } catch (error) {
    console.error("Error updating message:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

// DELETE
app.delete("/messages/:id", async (req, res) => {
  const { id } = req.params;
  try {
    // Find and delete the message by ID
    const message = await Message.findOne({ where: { id } });

    if (!message) {
      return res.status(404).json({ message: "Message not found" });
    }
    // Delete the message
    await message.destroy();
    res.status(200).json({ message: "Message deleted successfully" });
    io.emit("message_deleted", { id });
  } catch (error) {
    console.error("Error deleting message:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

app.delete("/contacts/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const contact = await Contact.findOne({ where: { id } });
    if (!contact) {
      return res.status(404).json({ message: "contact not found" });
    }
    await contact.destroy();
    res.status(200).json({ message: "contact deleted successfully" });
    io.emit("contact_deleted", { id });
  } catch (error) {
    console.error("Error deleting contact:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});
