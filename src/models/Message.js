const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Message = sequelize.define('Message', {
  status: {
    type: DataTypes.STRING,
    allowNull: false
  },
  phoneNumber: {
    type: DataTypes.STRING,
    allowNull: false
  },
  userName: {
    type: DataTypes.STRING,
    allowNull: false
  },
  message: {
    type: DataTypes.TEXT,
    allowNull: false
  },
  date: {
    type: DataTypes.DATE,
    allowNull: false
  },
  hour: {
    type: DataTypes.TIME,
    allowNull: false
  },
  pic: {
    type: DataTypes.STRING,
    allowNull: false
  },
  no_pic: {
    type: DataTypes.STRING,
    allowNull: false
  },
  reply_message: {
    type: DataTypes.TEXT,
    allowNull: false
  },
  reply_time: {
    type: DataTypes.DATE,
    allowNull: false
  },
  reply_pic: {
    type: DataTypes.TEXT,
    allowNull: false
  },
  media: {
    type: DataTypes.STRING,
    allowNull: true,
  },
}, {
  timestamps: true
});

module.exports = Message;
